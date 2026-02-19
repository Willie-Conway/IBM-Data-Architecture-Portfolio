// script.js
const glossaryData = [
    // Connectors Category
    {
        term: "API Connectors",
        definition: "Connectors that utilize APIs to integrate applications and services",
        category: "connector",
        example: "A weather application using OpenWeatherMap API to fetch real-time weather data for display, or a payment gateway like Stripe integrating with an e-commerce site to process transactions."
    },
    {
        term: "Application connectors",
        definition: "Connectors that integrate data from enterprise applications, such as ERP and CRM systems",
        category: "connector",
        example: "Salesforce connector pulling customer data into a marketing automation platform like HubSpot, or SAP connector syncing inventory data with an e-commerce platform."
    },
    {
        term: "Cloud connectors",
        definition: "Connectors that enable data transfer between cloud-based applications and services",
        category: "connector",
        example: "AWS S3 connector transferring files to Google Cloud Storage, or a connector syncing data between Salesforce and AWS Redshift."
    },
    {
        term: "Custom connectors",
        definition: "Connectors developed to address specific integration needs not met by standard connectors are often used to link proprietary systems",
        category: "connector",
        example: "A custom-built connector for a legacy mainframe system to modern cloud applications, or a connector for proprietary IoT devices to send data to Azure IoT Hub."
    },
    {
        term: "Data connectors",
        definition: "Software tools that facilitate data transfer between systems",
        category: "connector",
        example: "Fivetran or Stitch data connectors pulling data from various sources (databases, APIs, files) into a data warehouse like Snowflake."
    },
    {
        term: "Database connectors",
        definition: "Connectors that manage data flow between different database systems, such as SQL and NoSQL",
        category: "connector",
        example: "JDBC driver connecting Java applications to MySQL databases, or MongoDB connector syncing data with Elasticsearch for search functionality."
    },
    {
        term: "File-based connectors",
        definition: "Connectors that manage data integration through file transfers, using formats like CSV, XML, and JSON",
        category: "connector",
        example: "An SFTP connector that picks up CSV files from a server and loads them into a data warehouse, or a connector processing XML feeds from trading partners."
    },

    // Storage Category
    {
        term: "Block storage",
        definition: "Stores data in fixed-size chunks that you can manage independently",
        category: "storage",
        example: "Amazon EBS volumes attached to EC2 instances for database storage, or SAN storage for virtual machine file systems."
    },
    {
        term: "Cloud storage",
        definition: "Storage on remote servers accessed via the Internet",
        category: "storage",
        example: "Google Drive for personal file storage, Amazon S3 for hosting website assets, or Dropbox for business file sharing and collaboration."
    },
    {
        term: "Direct-Attached Storage (DAS)",
        definition: "Storage devices directly connect to a computer",
        category: "storage",
        example: "External hard drive connected via USB to a laptop for backups, or internal SSD drives in a server for local application storage."
    },
    {
        term: "File storage",
        definition: "Manages data as files, organizing them into a hierarchical structure of directories and files",
        category: "storage",
        example: "Network drives in a corporate network, or a media server storing videos and music in organized folders for streaming."
    },
    {
        term: "Hard disk drives (HDD)",
        definition: "Type of data storage which uses spinning disks to store and access data",
        category: "storage",
        example: "Traditional computer hard drives for bulk data storage, or external backup drives using spinning disks for cost-effective large capacity storage."
    },
    {
        term: "Hybrid cloud",
        definition: "Combines elements of both public and private cloud storage models",
        category: "storage",
        example: "A company storing sensitive customer data on private cloud but using public cloud for less sensitive data and burst computing needs."
    },
    {
        term: "Magnetic tape",
        definition: "Type of data storage which uses magnetic tape to store and access data",
        category: "storage",
        example: "Long-term archival storage for compliance data, or backup systems for large enterprises storing years of transaction records."
    },
    {
        term: "Memory",
        definition: "Temporarily holds data actively being processed",
        category: "storage",
        example: "RAM in a computer running multiple applications, or Redis caching frequently accessed database queries for faster response times."
    },
    {
        term: "Network-attached storage (NAS)",
        definition: "Storage that connects directly to a network, allowing multiple users to access data remotely",
        category: "storage",
        example: "Synology NAS in a small office for file sharing and backups, or a media server streaming content to multiple devices at home."
    },
    {
        term: "Optical storage",
        definition: "Type of data storage which uses laser technology to store and access data",
        category: "storage",
        example: "Blu-ray discs for 4K movie distribution, or archival CDs/DVDs for long-term storage of photos and documents."
    },
    {
        term: "Private cloud",
        definition: "Provides cloud infrastructure dedicated to a single organization",
        category: "storage",
        example: "A bank's internal cloud infrastructure for secure customer data processing, or a government agency's private cloud for classified information."
    },
    {
        term: "Public cloud",
        definition: "Provides services and infrastructure to third parties over the internet",
        category: "storage",
        example: "Netflix using AWS for streaming services, or Spotify using Google Cloud for music streaming and user data storage."
    },
    {
        term: "Solid state drives (SSD)",
        definition: "Type of data storage which uses flash memory to store data and access data",
        category: "storage",
        example: "Modern laptops using NVMe SSDs for fast boot times, or gaming PCs using SSDs for quick game loading and level transitions."
    },
    {
        term: "Storage",
        definition: "Technologies and processes used to retain digital data",
        category: "storage",
        example: "A comprehensive backup strategy using multiple storage types: SSDs for active data, HDDs for nearline storage, and tape for archives."
    },
    {
        term: "Storage area network (SAN)",
        definition: "Storage that connects multiple storage devices to multiple servers",
        category: "storage",
        example: "Enterprise data center using Fibre Channel SAN for database storage, or virtualized environment with SAN providing storage for multiple VMs."
    },

    // Protocols Category
    {
        term: "Apple Filing Protocol (AFP)",
        definition: "File storage protocol that allows macOS users to share files and access file servers over a network",
        category: "protocol",
        example: "Mac computer connecting to a Time Capsule for backups, or macOS clients accessing files on a macOS Server in a design agency."
    },
    {
        term: "Fiber Channel (FC)",
        definition: "High-speed block storage protocol that operates at speeds up to 128 gigabytes per second making it suitable for environments requiring high-performance data transfer",
        category: "protocol",
        example: "Large financial institutions using FC SAN for high-frequency trading databases, or video production houses transferring 8K video files."
    },
    {
        term: "Fiber Channel over Ethernet (FCoE)",
        definition: "Storage protocol that allows the transmission of fiber channel traffic over Ethernet networks",
        category: "protocol",
        example: "Data center consolidating storage and network traffic over 10GbE cables, reducing the need for separate FC infrastructure."
    },
    {
        term: "Internet Small Computer System Interface (iSCSI)",
        definition: "Block storage protocol that enables the transmission of SCSI commands over IP networks",
        category: "protocol",
        example: "Small business using iSCSI to connect servers to a storage array over existing network infrastructure, or VMware environment using iSCSI datastores."
    },
    {
        term: "Network file system (NFS)",
        definition: "File storage protocol developed by Sun Microsystems that allows users to access files over a network as if they were on their local machine",
        category: "protocol",
        example: "Linux servers sharing /home directories via NFS, or Kubernetes pods using NFS for persistent storage."
    },
    {
        term: "Non-volatile memory express (NVMe)",
        definition: "Storage protocol designed for high-speed solid-state drives and leverages low latency and high throughput of modern SSDs to deliver significantly better performance than traditional storage",
        category: "protocol",
        example: "Gaming PCs with NVMe SSDs for 3-second boot times, or AI/ML workloads requiring ultra-fast data access from NVMe drives."
    },
    {
        term: "Serial Attached SCSI (SAS)",
        definition: "Point-to-point block storage protocol that evolved from the parallel SCSI interface. It is primarily used for connecting servers to high-performance storage devices like hard drives and SSDs",
        category: "protocol",
        example: "Enterprise servers using SAS SSDs for database transaction logs, or storage arrays with SAS backplanes for drive connectivity."
    },
    {
        term: "Server Message Block/Common Internet File System (SMB/CIFS)",
        definition: "File storage protocol that provides file sharing, allowing users and applications to access files on remote servers",
        category: "protocol",
        example: "Windows file sharing in corporate networks, or macOS connecting to Windows shares for cross-platform file access."
    },
    {
        term: "Small Computer System Interface (SCSI)",
        definition: "Block storage protocol that connects computers to peripheral devices like hard drives and printers. Often used in conjunction with other protocols to facilitate communication between servers and storage devices",
        category: "protocol",
        example: "Legacy servers with SCSI hard drives, or tape libraries using SCSI commands for backup operations."
    },
    {
        term: "Storage protocol",
        definition: "Dictate how storage devices and systems that access them communicate using rules and standards",
        category: "protocol",
        example: "A storage administrator choosing between iSCSI, Fibre Channel, or NFS based on performance requirements, budget, and existing infrastructure."
    },

    // Processes Category
    {
        term: "Change data capture (CDC)",
        definition: "Track and capture changes in the source data when it gets updated and transfer updates to the target system in real-time",
        category: "process",
        example: "Debezium capturing MySQL database changes and streaming them to Kafka for real-time analytics, or Oracle GoldenGate replicating changes to a data warehouse."
    },
    {
        term: "Data extraction",
        definition: "The process of retrieving data from the original source system",
        category: "process",
        example: "Python script extracting sales data from a SQL Server database using pandas, or web scraping tool extracting product prices from e-commerce websites."
    },
    {
        term: "Data integration",
        definition: "Consolidating data from different sources to provide a single, coherent view",
        category: "process",
        example: "Combining customer data from CRM, support tickets, and website analytics into a single customer 360 view in a data warehouse."
    },
    {
        term: "Data loading",
        definition: "The process of inserting transformed data into the destination system",
        category: "process",
        example: "Bulk loading millions of records into Snowflake using COPY command, or streaming data into Elasticsearch for real-time search."
    },
    {
        term: "Data mapping",
        definition: "Aligning data fields between source and destination systems for accurate data transfer",
        category: "process",
        example: "Mapping 'cust_id' in source database to 'customerIdentifier' in target API, or transforming date formats from MM/DD/YYYY to YYYY-MM-DD."
    },
    {
        term: "Data replication",
        definition: "Make a copy of the data from one system to another to ensure availability",
        category: "process",
        example: "MySQL master-slave replication for high availability, or AWS DMS replicating an Oracle database to Amazon RDS for disaster recovery."
    },
    {
        term: "Data synchronization",
        definition: "Ensuring that data remains consistent and up-to-date across connected systems, either in real-time or on a scheduled basis",
        category: "process",
        example: "Mobile app syncing local SQLite database with cloud backend when connectivity is restored, or two-way sync between Salesforce and an ERP system."
    },
    {
        term: "Data transformation",
        definition: "The process of converting extracted data into a format compatible with the target system",
        category: "process",
        example: "dbt transforming raw JSON logs into structured tables, or Apache Spark converting CSV files to Parquet format for efficient querying."
    },
    {
        term: "Data virtualization",
        definition: "Create a virtual data layer that leaves data in its source but provides an interface integrates to consume and use the data without moving or copying it",
        category: "process",
        example: "Denodo platform creating virtual views across multiple databases, or Trino querying data across S3, MySQL, and Kafka without moving it."
    },
    {
        term: "Extract-Load-Transform (ELT)",
        definition: "Three steps from source to destination: extract from source, load into the target system, and transform data in target system",
        category: "process",
        example: "Loading raw JSON data into Snowflake first, then using SQL to transform it into star schema for analytics."
    },
    {
        term: "Extract-Transform-Load (ETL)",
        definition: "Three steps from source to destination: extract from source, transform by cleaning and formatting, and load into the target system",
        category: "process",
        example: "Informatica reading from mainframe, cleaning and aggregating data, then loading into a data warehouse for reporting."
    },
    {
        term: "Hub-and-spoke",
        definition: "Data integration pattern with a central hub that connects all systems, reducing the number of direct connections",
        category: "process",
        example: "Enterprise service bus (ESB) acting as central hub connecting CRM, ERP, and HR systems, each system only connects to the hub."
    },
    {
        term: "Integration patterns",
        definition: "Best practices to ensure efficient and effective data integration",
        category: "process",
        example: "Using message queues for asynchronous integration, implementing retry logic with exponential backoff, or choosing between batch and real-time processing based on requirements."
    },
    {
        term: "Point-to-point",
        definition: "Direct, individual connections between data sources and destinations",
        category: "process",
        example: "Custom scripts moving data directly from MySQL to PostgreSQL, or API integration between a single source and destination without middleware."
    },
    {
        term: "Primary-replica backup configuration",
        definition: "Storing and processing data in a primary system and replicating the data in real-time or at regular intervals to a secondary system",
        category: "process",
        example: "PostgreSQL primary server in us-east-1 with read replica in us-west-2 for disaster recovery, or MongoDB replica set with primary and secondary nodes."
    }
];

// Function to determine category class
function getCategoryClass(category) {
    switch(category) {
        case 'connector': return 'category-connector';
        case 'storage': return 'category-storage';
        case 'protocol': return 'category-protocol';
        case 'process': return 'category-process';
        default: return '';
    }
}

// Function to format category name
function formatCategoryName(category) {
    return category.charAt(0).toUpperCase() + category.slice(1) + 's';
}

// Function to create glossary item HTML
function createGlossaryItem(item) {
    return `
        <div class="glossary-item" data-category="${item.category}" data-term="${item.term.toLowerCase()}">
            <div class="term-header">
                <span class="term-name">${item.term}</span>
                <span class="term-category ${getCategoryClass(item.category)}">${formatCategoryName(item.category)}</span>
            </div>
            <div class="definition">${item.definition}</div>
            <div class="example-section">
                <div class="example-title">Real-World Example</div>
                <div class="example-content">${item.example}</div>
            </div>
        </div>
    `;
}

// Function to render glossary
function renderGlossary(items) {
    const glossaryList = document.getElementById('glossaryList');
    glossaryList.innerHTML = items.map(item => createGlossaryItem(item)).join('');
    updateCounts();
}

// Function to filter glossary
function filterGlossary() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const activeFilter = document.querySelector('.filter-btn.active').dataset.filter;
    
    const filteredData = glossaryData.filter(item => {
        // Check search term
        const matchesSearch = searchTerm === '' || 
            item.term.toLowerCase().includes(searchTerm) ||
            item.definition.toLowerCase().includes(searchTerm) ||
            item.example.toLowerCase().includes(searchTerm);
        
        // Check category filter
        const matchesFilter = activeFilter === 'all' || item.category === activeFilter;
        
        return matchesSearch && matchesFilter;
    });
    
    renderGlossary(filteredData);
    
    // Show no results message if needed
    const glossaryList = document.getElementById('glossaryList');
    if (filteredData.length === 0) {
        glossaryList.innerHTML = '<div class="no-results">🔍 No terms found matching your criteria</div>';
    }
}

// Function to update counts
function updateCounts() {
    const totalCount = glossaryData.length;
    const visibleCount = document.querySelectorAll('.glossary-item').length;
    
    document.getElementById('totalCount').textContent = totalCount;
    document.getElementById('visibleCount').textContent = visibleCount;
}

// Function to highlight search terms
function highlightSearchTerm() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    if (!searchTerm) return;
    
    const items = document.querySelectorAll('.glossary-item');
    items.forEach(item => {
        const termElement = item.querySelector('.term-name');
        const definitionElement = item.querySelector('.definition');
        const exampleElement = item.querySelector('.example-content');
        
        // This is a simplified version - for production, you'd want a more robust highlighting solution
        // that doesn't break HTML structure
    });
}

// Initialize glossary
document.addEventListener('DOMContentLoaded', () => {
    // Sort glossary data alphabetically
    glossaryData.sort((a, b) => a.term.localeCompare(b.term));
    
    // Initial render
    renderGlossary(glossaryData);
    
    // Search input handler with debounce
    let searchTimeout;
    document.getElementById('searchInput').addEventListener('input', () => {
        clearTimeout(searchTimeout);
        searchTimeout = setTimeout(() => {
            filterGlossary();
        }, 300);
    });
    
    // Filter button handlers
    document.querySelectorAll('.filter-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            // Update active button
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            
            // Apply filter
            filterGlossary();
        });
    });
    
    // Keyboard shortcut for search (Ctrl/Cmd + K)
    document.addEventListener('keydown', (e) => {
        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
            e.preventDefault();
            document.getElementById('searchInput').focus();
        }
    });
    
    // Add keyboard navigation for filter buttons (1-5 keys)
    document.addEventListener('keydown', (e) => {
        const key = e.key;
        if (key >= '1' && key <= '5') {
            const index = parseInt(key) - 1;
            const buttons = document.querySelectorAll('.filter-btn');
            if (buttons[index]) {
                buttons[index].click();
            }
        }
    });
    
    console.log('Glossary initialized! Use Ctrl/Cmd + K to focus search, or 1-5 keys for filters.');
});