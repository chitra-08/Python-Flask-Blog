-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 09, 2021 at 07:40 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.4.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chitrablog`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'Test User', 'testuser@abc.com', '0050000', 'This is to auto increment the srno', '2021-11-06 18:14:43'),
(2, 'Chitra', 'chits@abc.com', '9876126789', 'This is my first msg.', NULL),
(3, 'Myra', 'mishu@abc.com', '8976125678', 'Mishu is Myraaaa..', '2021-11-06 18:49:44'),
(4, 'Pista', 'pista@badam.com', '908976', 'pista badam milk', '2021-11-06 20:08:50'),
(5, 'Myra', 'mishu@abc.com', '8976125678', 'Mishu is Myraaaa..', '2021-11-06 20:09:50'),
(6, 'Joey', 'joey@ac.com', '9089781234', 'Joey says hello... baauu baauu..', '2021-11-07 08:42:03'),
(7, 'Joey', 'joey@ac.com', '9089781234', 'Joey says hello... baauu baauu..', '2021-11-07 08:42:34'),
(8, 'Joey', 'joey@ac.com', '9089781234', 'Joey says hello... baauu baauu..', '2021-11-07 08:44:15'),
(9, 'Joey', 'joey@ac.com', '9089781234', 'Joey says hello... baauu baauu..', '2021-11-07 08:46:03');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(30) NOT NULL,
  `tagline` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `date`, `img_file`, `tagline`) VALUES
(1, 'This is the first post on my Blog', 'first-post', 'Like any new situation, it’s important to introduce yourself and give people a chance to get to know you. In your first blog post, tell your readers who you are, what your blog is about and why you are blogging. Even a short introductory paragraph can be enough to give your readers an idea of what they can expect..\n\nIf you are planning to publish guest blogs or host different authors, you might want to mention that or even introduce them as well. Also, don’t forget to include relevant keywords in the title, like “First post” or “Welcome”,  so your readers will know right away where they’ve landed. Establish Your Editorial Plan\n\nMaking the decision to start a blog is easy. Thinking up new and original topics for blog posts on a regular basis is much harder. Once your blog is ready for launch, invest time in creating an editorial calendar. Map out your first few weeks of blog post topics, but remember, it’s not written in stone. You can always change or adapt the calendar as you go along or as needed.\n\nA great way to get into the blog writing zone is by reading other blogs. That way, you’ll discover what content is already out there, and you can work on refining a new angle or perspective that makes your blog original and worth reading.\n\nA clever tactic is to read a blog that you don’t agree with, or which takes a different view to yours. Then, write a post from the opposite viewpoint, and get your readers really engaged. This can be a great way to create a buzz around your first blog entry.', '2021-11-07 09:14:58', 'post-bg.jpg', 'Read about my first blog'),
(2, 'Know about Instagram Flatlays', 'insta-post-flatlays', 'The best flat lays tell a visual story, so choose a theme, using a couple of \'star\' items surrounded by a \'supporting cast\' of additional elements. Go for harmonious, complementary colours, and keep things simple – less is often more. The most popular format for flat lays is square, and within that square you want to be aiming for a clean, easy-to-read composition. Whether you go for a square, portrait or landscape format, use the rule of thirds to guide you – imagine a noughts and crosses grid overlaying the image, and position the most important elements roughly where the gridlines intersect.', '2021-11-07 10:27:08', 'about-bg.jpg', 'Interesting facts about flatlays and related articles'),
(3, 'Kitchen\'s Day', 'cook-food', 'Cooking, cookery, or culinary arts is the art, science, and craft of using heat to prepare food for consumption. Cooking techniques and ingredients vary widely, from grilling food over an open fire to using electric stoves, to baking in various types of ovens, reflecting local conditions.Types of cooking also depend on the skill levels and training of the cooks. Cooking is done both by people in their own dwellings and by professional cooks and chefs in restaurants and other food establishments.Preparing food with heat or fire is an activity unique to humans. It may have started around 2 million years ago, though archaeological evidence for the same does not predate more than 1 million years.[1]The expansion of agriculture, commerce, trade, and transportation between civilizations in different regions offered cooks many new ingredients. New inventions and technologies, such as the invention of pottery for holding and boiling of water, expanded cooking techniques. Some modern cooks apply advanced scientific techniques to food preparation to further enhance the flavor of the dish served.', '2021-11-07 10:44:50', 'home-bg.jpg', 'Cooking your favourites'),
(4, 'Mobile Photography 1', 'mobile-photos', 'Before the days of smartphones — if you can remember such a time — taking a great photo was a labor-intensive process. You\'d have to buy a fancy camera and editing software for your desktop computer, and invest some serious time and energy into learning how to use them.But, thanks to our mobile devices and the editing apps that come with them, we can now take high-quality photos and edit them without too many bells and whistles — all from the same device that we use to make calls.Brands are catching on, too — these kinds of visuals remain important to marketing. But make no mistake: Taking a great photo on your smartphone is not as simple as pointing and shooting. There are plenty of bad smartphone photos out there — I\'m sure you\'ve seen at least a few.What\'s the secret to taking great pictures with your smartphone, then? As it turns out, there are a few of them. Check out these tips below to improve your smartphone photography game. (And once you have the photo-taking part down, check out some of the best photo editing apps for mobile.)', '2021-11-07 10:47:24', 'about-bg.jpg', 'Upgrade your photography skills - Part 1'),
(5, 'Work from Home During Pandemic', 'post-wfh', 'Work from home during pandemic. This has brought a new topic of discussion.', '2021-11-07 20:41:00', 'about-bg.jpg', 'Stressful or Relaxing?'),
(8, 'Pagination -1', 'page1-1', 'dsfdsf', '2021-11-09 23:22:55', 'page.jpg', 'Check pagination'),
(9, 'Pagination -2', 'page2-2', 'opopyusad sahdghsagdas', '2021-11-09 23:23:21', 'page2.jpg', 'check pagination 2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
