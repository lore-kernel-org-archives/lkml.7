Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA66C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA9B20835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 03:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfCDD6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 22:58:00 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:36741 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfCDD6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 22:58:00 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TLtwN0Q_1551671875;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TLtwN0Q_1551671875)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 04 Mar 2019 11:57:56 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     linux-kernel@zh-kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, harryxiyou@gmail.com, corbet@lwn.net
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH 00/20] origanize Chinese kernel docs
Date:   Mon,  4 Mar 2019 11:57:23 +0800
Message-Id: <20190304035744.155203-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following patch aims to upstream kernel doc.

you can view them with the link http://176.122.172.82/translations/zh_CN/index.html 

Or make and review docs on your self box:

	make htmldocs SPHINXDIRS=translations/zh_CN 
	lynx Documentation/output/translations/zh_CN/index.html

Any comments are appreciated!

Cheers!
Alex

---
Alex Shi (20):
  docs/zh_CN: add disclaimer file
  docs/zh_CN: move process related docs into process dir
  docs/zh_CN: change Chinese index to know process dir
  docs/zh_CN: add index file into process dir
  docs/zh_CN: rename HOWTO into process directory
  docs/zh_CN: howto format changes
  docs/zh_CN: rename SubmittingPatches for html links
  docs/zh_CN: format the submitting-patches doc to rst
  docs/zh_CN: rename stable_kernel_rules doc
  docs/zh_CN: rst format change for stable-kernel-rules
  docs/zh_CN: rename email-clients.txt as email-clients.rst
  docs/zh_CN: do rst format for email-clients.rst
  docs/zh_CN: rename volatile-consider-harmful doc
  docs/zh_CN: volatile doc format changes
  docs/zh_CN: rename SubmittingDrivers
  docs/zh_CN: format submitting drivers as rst
  docs/zh_CN: rename magic-numbers as rst doc
  docs/zh_CN: format the magic-number doc as rst
  docs/zh_CN: rename stable_api_nonsense.txt as stable-api-nonsense.rst
  docs/zh_CN: format stable-api-nonsense

 .../translations/zh_CN/disclaimer-zh_CN.rst   |  11 ++
 Documentation/translations/zh_CN/index.rst    |  17 +-
 .../translations/zh_CN/magic-number.txt       | 153 ------------------
 .../zh_CN/{ => process}/coding-style.rst      |   0
 .../email-clients.rst}                        |  53 +++---
 .../zh_CN/{HOWTO => process/howto.rst}        |  37 ++---
 .../translations/zh_CN/process/index.rst      |  55 +++++++
 .../zh_CN/process/magic-number.rst            | 151 +++++++++++++++++
 .../stable-api-nonsense.rst}                  |  32 ++--
 .../stable-kernel-rules.rst}                  |  32 ++--
 .../submitting-drivers.rst}                   |  30 ++--
 .../submitting-patches.rst}                   |  36 ++---
 .../volatile-considered-harmful.rst}          |  35 ++--
 13 files changed, 334 insertions(+), 308 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst
 delete mode 100644 Documentation/translations/zh_CN/magic-number.txt
 rename Documentation/translations/zh_CN/{ => process}/coding-style.rst (100%)
 rename Documentation/translations/zh_CN/{email-clients.txt => process/email-clients.rst} (82%)
 rename Documentation/translations/zh_CN/{HOWTO => process/howto.rst} (95%)
 create mode 100644 Documentation/translations/zh_CN/process/index.rst
 create mode 100644 Documentation/translations/zh_CN/process/magic-number.rst
 rename Documentation/translations/zh_CN/{stable_api_nonsense.txt => process/stable-api-nonsense.rst} (89%)
 rename Documentation/translations/zh_CN/{stable_kernel_rules.txt => process/stable-kernel-rules.rst} (76%)
 rename Documentation/translations/zh_CN/{SubmittingDrivers => process/submitting-drivers.rst} (86%)
 rename Documentation/translations/zh_CN/{SubmittingPatches => process/submitting-patches.rst} (93%)
 rename Documentation/translations/zh_CN/{volatile-considered-harmful.txt => process/volatile-considered-harmful.rst} (81%)

-- 
2.19.1.856.g8858448bb

