import 'package:flutter/material.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;

class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custom_search.SearchBar() as PreferredSizeWidget?,
      body: Column(
        children: [
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
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    job.location,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  job.datePosted,
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.bookmark_border),
                    ),
                    if (index < jobListings.length - 1)
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
