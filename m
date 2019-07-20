Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48704C76195
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F7217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 13:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=firemail.cc header.i=@firemail.cc header.b="pNDrm8r0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfGTNZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 09:25:05 -0400
Received: from mx1.cock.li ([185.10.68.5]:33767 "EHLO cock.li"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbfGTNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 09:25:04 -0400
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Jul 2019 09:25:03 EDT
From:   Robert Karszniewicz <avoidr@firemail.cc>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1563628580; bh=T03mKEFFc55zmeKdDGqPIZVXFGNylYNZH2hF6DUQIKc=;
        h=From:To:Cc:Subject:Date:From;
        b=pNDrm8r0DYSQC3XbevN8dNzpq82uKBNQ+cDroXCENpPnR6XSYKIMTSjroT/gpkuhh
         Apig4jjG3OLbERIPrifKMyzcZQGnF2KnXcM6jDoxgTkZ+W6Wta99ZPFu0HjPV/9YV+
         VJXD2PjyE+CvDPBr8oeD/ht1t89ATjyOEnbv+tDfWml7RdGH2EhivRXMwjvsJe7QRG
         L3GtnLbMX0fP1PzEQszdlzNKHdNhwzwGUqv4IS7KReEI6Qe4hx+0796DJUgFqe65rw
         lxJaxVDwP4GB7wxi+SdydaUrW6MBmtQCajhUQbtXtGFmkCjkCLQxMoADV8KDSJpzIi
         74Y8QqWb5bNGg==
To:     Rudolf Marek <r.marek@assembler.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Robert Karszniewicz <avoidr@firemail.cc>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] hwmon: (k8temp) update to use new hwmon registration API
Date:   Sat, 20 Jul 2019 15:15:54 +0200
Message-Id: <cover.1563522498.git.avoidr@firemail.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiled and ran against 5.2.0-next-20190718.

I did not know how to manipulate `type`, `attr`, and `channel` arguments
to is_visible() and read(), so I did not test that. But it works in
normal use (`sensors` and reading the sysfs files directly).

Robert Karszniewicz (2):
  hwmon: (k8temp) update to use new hwmon registration API
  hwmon: (k8temp) documentation: update URL of datasheet

 Documentation/hwmon/k8temp.rst |   2 +-
 drivers/hwmon/k8temp.c         | 204 +++++++++++++++------------------
 2 files changed, 93 insertions(+), 113 deletions(-)

-- 
2.22.0

