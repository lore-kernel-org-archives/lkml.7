Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA0C2D0DA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 08:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982CA2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 08:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLYIdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 03:33:04 -0500
Received: from mail01.vodafone.es ([217.130.24.71]:15831 "EHLO
        mail01.vodafone.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfLYIdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 03:33:04 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Dec 2019 03:33:03 EST
IronPort-SDR: SmEfcnk4EyZtFklqbUH1X/7IiddCT5OxrhddpEL6Nmm2+urv9zxY/RaBuAlYx1NcetoiK/e5zj
 mfhbqLczaVsw==
IronPort-PHdr: =?us-ascii?q?9a23=3A+wBHkxbGhn6X00X3Da7IPUr/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr829bnLW6fgltlLVR4KTs6sC17ON9fq6Aidfu96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vIhi6txvdutcYjIdtKKs91A?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDM/7WrZiNF/jLhDrRyvpxJ/2ZDaboKIOvVxYqzTcsgXRX?=
 =?us-ascii?q?ZDU8lNSyBNHp+wY5UJAuEcPehYtY79p14WoBW4HwanGfnhyiVJhn/z3K06z+?=
 =?us-ascii?q?UhER/c0wc9GN8OrGnUrNHpO6cTTO+61rLIwC7Gb/xM2Df97JLEcgw/rvGIQ7?=
 =?us-ascii?q?1wadDexlU1GwPdklWdsIroNC6W2OQVq2WX8fdsWOC1h2I6pQx9viKjytkjh4?=
 =?us-ascii?q?XTiI8YylbJ/jhjzokvP923Ukt7bMahEJtXqi6VKZN7QtgnQ2F0oCY6zaAGuY?=
 =?us-ascii?q?KjcCgK1psnwxnfZuSCc4eS4xLjUPyRLil8hH55d7+znQiy8U+9xeLmWMm011?=
 =?us-ascii?q?BKoTRfntbSrXABzx3T6s6ZRfth5kqtxyuD2gLJ5u1ZL004ibDXJ4Auz7IqmJ?=
 =?us-ascii?q?cesVzPHirsl0X3iK+WeF8k+u+t6+n/frXmu5ucOJN1ig7jKKsugdeyAeEiPQ?=
 =?us-ascii?q?gPW2iX4/i826Pn/ULnWLVFlOE5nrPBsJDGPcgbvLK2AxdJ0oY/7BayFzOm0N?=
 =?us-ascii?q?UenXkaI1NJYRGHgJbzO1HIPv/4Ceyyg0qjkDh13fDKJL7hDYvXLnjFjrjhea?=
 =?us-ascii?q?xx60lGyAo8nphj4MdQC7ccMLfwV1X3udjwEBA0KUq3zvzhBdE70ZkRCliCGq?=
 =?us-ascii?q?uIDKSHlVbA3vguJuiQZZEc8GL5IuA/5vvvkX4nkFIGVbuu3ZwSYXG8WPl7dR?=
 =?us-ascii?q?a3e33p1/MIWV8Qvw8/UO30gRXWTSNXbHe+VrkU4zg6DMS6AIPOXommxqSdin?=
 =?us-ascii?q?ToVqZKb3xLXwjfWUzjcJ+JDq8B?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GTKgAeHQNemCMYgtllgkQBGAEBgns?=
 =?us-ascii?q?3GyASk0JUBnUdihKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQU?=
 =?us-ascii?q?BAQEBAQUEAQECEAEBAQEBCAsLBimFSkIBDAGBayKEF4EDgSyDA4JTKa0WGgK?=
 =?us-ascii?q?FI4R1gTYBjBgaeYEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDg?=
 =?us-ascii?q?DglSJEacigjdVgQuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IPAS-Result: =?us-ascii?q?A2GTKgAeHQNemCMYgtllgkQBGAEBgns3GyASk0JUBnUdi?=
 =?us-ascii?q?hKFM4N8FYYaDIFbDQEBAQEBNQIBAYRAgiIkOBMCAw0BAQUBAQEBAQUEAQECE?=
 =?us-ascii?q?AEBAQEBCAsLBimFSkIBDAGBayKEF4EDgSyDA4JTKa0WGgKFI4R1gTYBjBgae?=
 =?us-ascii?q?YEHgUSCMoUCARIBbIUhBI1FIYhLYZd+gj4EljANgikBjDgDglSJEacigjdVg?=
 =?us-ascii?q?QuBCnFNOIFyGYEdTxgNjSyOLUCBFhACT4VAh1yCMgEB?=
X-IronPort-AV: E=Sophos;i="5.69,353,1571695200"; 
   d="scan'208";a="298603235"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail01.vodafone.es with ESMTP; 25 Dec 2019 09:27:57 +0100
Received: (qmail 32198 invoked from network); 25 Dec 2019 04:33:51 -0000
Received: from unknown (HELO 192.168.1.88) (seigo@[217.217.179.17])
          (envelope-sender <tulcidas@mail.telepac.pt>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-kernel@vger.kernel.org>; 25 Dec 2019 04:33:51 -0000
Date:   Wed, 25 Dec 2019 05:33:42 +0100 (CET)
From:   La Primitiva <tulcidas@mail.telepac.pt>
Reply-To: La Primitiva <laprimitivaes@zohomail.eu>
To:     linux-kernel@vger.kernel.org
Message-ID: <24134421.259371.1577248422827.JavaMail.javamailuser@localhost>
Subject: Take home 750,000 Euros this end of year
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Attn: Email User,

You have won, you are to reply back with your name and phone number for
claim.

La Primitiva




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.

