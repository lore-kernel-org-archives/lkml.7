Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A8C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC6C520717
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 13:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfLQNXF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 08:23:05 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.113]:46773 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726191AbfLQNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 08:23:04 -0500
Received: from [85.158.142.199] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-b.eu-central-1.aws.symcld.net id F1/E1-12310-5B6D8FD5; Tue, 17 Dec 2019 13:23:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRWlGSWpSXmKPExsVyU+ECq+7Waz9
  iDeZdkbH4O+kYu0Xz4vVsFpd3zWFzYPb4/WsSo8f+uWvYPT5vkgtgjmLNzEvKr0hgzZi5pLDg
  G2/Fk4U7mRsYF3N3MXJxCAnsY5S4M/UoI4RzlFHi+Jef7F2MnBxsAmoS3cuWsoHYIgKGEq09q
  8HizAIZEk1nzzGD2MIC7hLTrm1kBbFZBFQlFs+bC1bDK2Alcf7KDRYQW0JAXmLrt0+sEHFBiZ
  Mzn7BAzNGWWLbwNdgcIQEliTN/PzB1MXIAxTUl1u/SBzElBKwlrn4pmcDINwtJ8ywkzbMQGhY
  wMq9itEwqykzPKMlNzMzRNTQw0DU0NNY1A5F6iVW6SXqppbrJqXklRYlAWb3E8mK94src5JwU
  vbzUkk2MwIBNKWQr3MF4/OtbvUOMkhxMSqK8b3f+iBXiS8pPqcxILM6ILyrNSS0+xCjDwaEkw
  dtzFSgnWJSanlqRlpkDjB6YtAQHj5II72KQNG9xQWJucWY6ROoUoy7H0462JcxCLHn5ealS4r
  x/rgAVCYAUZZTmwY2ARfIlRlkpYV5GBgYGIZ6C1KLczBJU+VeM4hyMSsK8q0Cm8GTmlcBtegV
  0BBPQEUZ+30COKElESEk1ME18e+XdpXsHiq+vmz3L2P/3ylg2j3Paz8+EljNu+cH4lnvxQTf/
  77rqW3Wfzl3wd37SdmldAeEvxy93sDT/u3pHI+WY3Bn17YX1rw9+/rvS5ObnRUaTRX7lyDywi
  nnw59jONyssdWuCT3TLBSrxWvka1m1pWsfqZBL8457G9pk7L/O9nlUVduizxO/LXfsdXk6t1O
  J5siNg05b/V+a5P9p/+a9+1y7uxNXqs3ov3N8x9/DXL95K957MeBf24Z1R0D8fjUg3nbW5Hvx
  fxF0/1gVfvn4vyGRGzObHG2wXhomeW38iXdjUjG3S6q/Ra0MO+f2ccG7tE+fngedkfRW4H0sb
  B1ltODjTIZvto6Hz5/fvdimxFGckGmoxFxUnAgB5NCOiXwMAAA==
X-Env-Sender: david.kim@ncipher.com
X-Msg-Ref: server-5.tower-244.messagelabs.com!1576588981!709446!1
X-Originating-IP: [217.32.208.5]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1976 invoked from network); 17 Dec 2019 13:23:01 -0000
Received: from unknown (HELO exukdagfar02.INTERNAL.ROOT.TES) (217.32.208.5)
  by server-5.tower-244.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Dec 2019 13:23:01 -0000
Received: from exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) by
 exukdagfar02.INTERNAL.ROOT.TES (10.194.2.71) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 17 Dec 2019 13:23:00 +0000
Received: from kimbop.ncipher.com (172.23.136.54) by
 exukdagfar01.INTERNAL.ROOT.TES (10.194.2.70) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 17 Dec 2019 13:23:00 +0000
From:   Dave Kim <david.kim@ncipher.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Dave Kim <david.kim@ncipher.com>,
        Tim Magee <tim.magee@ncipher.com>
Subject: [PATCH 0/1] drivers: misc: Add support for nCipher HSM devices
Date:   Tue, 17 Dec 2019 13:22:43 +0000
Message-ID: <20191217132244.14768-1-david.kim@ncipher.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="utf-8"
X-EXCLAIMER-MD-CONFIG: 7ae4f661-56ee-4cc7-9363-621ce9eeb65f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

﻿Hi all,

This patch introduces the nCipher Hardware Security Module (HSM) driver into
the linux kernel. Upstreaming the driver will allow early adopters of the 
latest kernel to upgrade and maintain their working systems when using an
nCipher PCIe HSM. Further, having this driver in the kernel will be more
convenient to our users and make a Linux based solution a more attractive
option for others.

Thanks,
Dave Kim 

Co-developed-by: Tim Magee <tim.magee@ncipher.com>

David Kim (1):
  drivers: misc: Add support for nCipher HSM devices

 MAINTAINERS                       |    8 +
 drivers/misc/Kconfig              |    1 +
 drivers/misc/Makefile             |    1 +
 drivers/misc/ncipher/Kconfig      |    8 +
 drivers/misc/ncipher/Makefile     |    7 +
 drivers/misc/ncipher/fsl.c        |  911 +++++++++++++++++
 drivers/misc/ncipher/fsl.h        |  117 +++
 drivers/misc/ncipher/hostif.c     | 1521 +++++++++++++++++++++++++++++
 drivers/misc/ncipher/i21555.c     |  553 +++++++++++
 drivers/misc/ncipher/i21555.h     |   68 ++
 drivers/misc/ncipher/solo.h       |  316 ++++++
 include/uapi/linux/nshield_solo.h |  181 ++++
 12 files changed, 3692 insertions(+)
 create mode 100644 drivers/misc/ncipher/Kconfig
 create mode 100644 drivers/misc/ncipher/Makefile
 create mode 100644 drivers/misc/ncipher/fsl.c
 create mode 100644 drivers/misc/ncipher/fsl.h
 create mode 100644 drivers/misc/ncipher/hostif.c
 create mode 100644 drivers/misc/ncipher/i21555.c
 create mode 100644 drivers/misc/ncipher/i21555.h
 create mode 100644 drivers/misc/ncipher/solo.h
 create mode 100644 include/uapi/linux/nshield_solo.h

-- 
2.24.1



David Kim
Senior Software Engineer
Tel: +44 1223 703449

nCipher Security
One Station Square
Cambridge CB1 2GA
United Kingdom

