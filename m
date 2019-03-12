Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625A4C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B9D3214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfCLDZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:25:32 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50200 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfCLDZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:25:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TMWKpsn_1552361124;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWKpsn_1552361124)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:25:25 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alex Shi <alex.shi@linux.alibaba.com>
Subject: [PATCH v4 00/31] clean up and reorg Chinese kernel docs 
Date:   Tue, 12 Mar 2019 11:24:29 +0800
Message-Id: <20190312032501.62056-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The following patches change existing Chinese kernel docs to rst format
and reorg them to make them alive in 'make htmldocs'.

you can view the generated htmldocs from:
	http://176.122.172.82/translations/zh_CN/index.html 

Or make and review docs on your self box:

	make htmldocs SPHINXDIRS=translations/zh_CN 
	lynx Documentation/output/translations/zh_CN/index.html

Any comments are appreciated!

V4 changes:
1, Add Harry's signed-off as his ack.

V3 changes:
1, fix a zh_CN/index.rst display issue
2, update .mailmap for zh_CN transolators'r email address

V2 changes:
1, change the disclaimer file to Chinese version,
2, replace the obsolete translator's email address in related files.
3, fix couple of format issues in couple files

Cheers!
Alex

Alex Shi (31):
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
  docs/zh_CN: update Li Yang's email address
  mailmap: update Li Yang's email address
  docs/zh_CN: update Zhang Wei's email address
  mailmap: update email address for Triplex
  docs/zh_CN: update TripleX chung's email address
  docs/zh_CN: fix rst format errors in howto.rst
  docs/zh_CN: fix indent issue in stable-api-nonsense file
  docs/zh_CN: fix indent issue in submitting-drivers
  docs/zh_CN: remove zh-kernel.org in MAINTAINERS
  mailmap: update my obsolete email address
  docs/zh_CN: fix rst format issue in submitting-patch

 .mailmap                                      |   6 +
 .../translations/zh_CN/disclaimer-zh_CN.rst   |   9 ++
 Documentation/translations/zh_CN/index.rst    |  17 +-
 .../translations/zh_CN/magic-number.txt       | 153 ------------------
 .../translations/zh_CN/oops-tracing.txt       |   2 +-
 .../zh_CN/{ => process}/coding-style.rst      |   0
 .../email-clients.rst}                        |  53 +++---
 .../zh_CN/{HOWTO => process/howto.rst}        |  69 +++++---
 .../translations/zh_CN/process/index.rst      |  53 ++++++
 .../zh_CN/process/magic-number.rst            | 151 +++++++++++++++++
 .../stable-api-nonsense.rst}                  |  67 ++++----
 .../stable-kernel-rules.rst}                  |  32 ++--
 .../submitting-drivers.rst}                   |  34 ++--
 .../submitting-patches.rst}                   |  58 +++----
 .../volatile-considered-harmful.rst}          |  35 ++--
 Documentation/translations/zh_CN/sparse.txt   |   6 +-
 MAINTAINERS                                   |   1 -
 17 files changed, 407 insertions(+), 339 deletions(-)
 create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst
 delete mode 100644 Documentation/translations/zh_CN/magic-number.txt
 rename Documentation/translations/zh_CN/{ => process}/coding-style.rst (100%)
 rename Documentation/translations/zh_CN/{email-clients.txt => process/email-clients.rst} (82%)
 rename Documentation/translations/zh_CN/{HOWTO => process/howto.rst} (95%)
 create mode 100644 Documentation/translations/zh_CN/process/index.rst
 create mode 100644 Documentation/translations/zh_CN/process/magic-number.rst
 rename Documentation/translations/zh_CN/{stable_api_nonsense.txt => process/stable-api-nonsense.rst} (80%)
 rename Documentation/translations/zh_CN/{stable_kernel_rules.txt => process/stable-kernel-rules.rst} (76%)
 rename Documentation/translations/zh_CN/{SubmittingDrivers => process/submitting-drivers.rst} (86%)
 rename Documentation/translations/zh_CN/{SubmittingPatches => process/submitting-patches.rst} (92%)
 rename Documentation/translations/zh_CN/{volatile-considered-harmful.txt => process/volatile-considered-harmful.rst} (81%)

-- 
2.19.1.856.g8858448bb

