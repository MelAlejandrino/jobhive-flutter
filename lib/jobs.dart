import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Sample data for the job listings
  List<JobListing> jobListings = [
    JobListing(
      logo: 'https://pngfre.com/wp-content/uploads/apple-logo-6-1024x1024.png',
      position: 'Javascript Developer',
      company: 'Apple',
      location: 'Manila, Philippines',
      datePosted: '1w',
    ),
    JobListing(
      logo: 'https://seeklogo.com/images/P/pepsi-logo-94d7def922-seeklogo.com.png',
      position: 'Project Manager',
      company: 'Pepsi',
      location: 'Davao City, Philippines',
      datePosted: '2w',
    ),
    JobListing(
      logo: 'https://devonxscott.com/wp-content/uploads/2018/05/samsung-logo.jpg',
      position: 'IT Technician',
      company: 'Samsung',
      location: 'Cagayan de Oro City, Philippines',
      datePosted: '2w',
    ),
    // Add more job listings as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          // Row containing "Saved jobs" and "Post a job" buttons
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.grey[400],
                  child: TextButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Saved jobs',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  color: Colors.grey[400],
                  child: TextButton(
                    onPressed: () {},
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.create,
                        color: Colors.black,
                      ),
                      label: const Text(
                        'Post a job',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Recommended
          const Padding(
            padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0 , 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Job listings with space between items
          Expanded(
            child: ListView.builder(
              itemCount: jobListings.length,
              itemBuilder: (context, index) {
                JobListing job = jobListings[index];
                return Column(
                  children: [
                    ListTile(
                      leading: SizedBox(
                        width: 64,
                        height: 64,
                        child: Image.network(job.logo),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job.position,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  job.company,
                                  style: TextStyle(color: Colors.grey[600]), // Lighter text color
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    job.location,
                                    style: TextStyle(color: Colors.grey[600]), // Lighter text color
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  job.datePosted,
                                  style: TextStyle(color: Colors.grey[600]), // Lighter text color
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.bookmark_border),
                    ),
                    if (index < jobListings.length - 1) // Add divider except for the last item
                      const Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class JobListing {
  final String logo;
  final String position;
  final String company;
  final String location;
  final String datePosted;

  JobListing({
  required this.logo,
  required this.position,
  required this.company,
  required this.location,
  required this.datePosted,
});
}
