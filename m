Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D78C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0292087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 03:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfCLDGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 23:06:46 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:53091 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfCLDGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 23:06:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TMWPdF9_1552360001;
Received: from Alexs-MacBook-Pro.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TMWPdF9_1552360001)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Mar 2019 11:06:42 +0800
Subject: Re: [PATCH v4 00/31] clean up and reorg Chinese kernel docs
To:     corbet@lwn.net, harryxiyou@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <d1cfbf70-b173-2a6c-67b9-892a0a4ee757@linux.alibaba.com>
Date:   Tue, 12 Mar 2019 11:06:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190312030129.47511-1-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please forget this series. I sent out the old patchset w/o Harry's signed-off. will rend soon.
Very sorry for disturb!

Thanks
Alex

On 2019/3/12 11:00 上午, Alex Shi wrote:
> The following patches change existing Chinese kernel docs to rst format
> and reorg them to make them alive in 'make htmldocs'.
>
> you can view the generated htmldocs from:
> 	http://176.122.172.82/translations/zh_CN/index.html 
>
> Or make and review docs on your self box:
>
> 	make htmldocs SPHINXDIRS=translations/zh_CN 
> 	lynx Documentation/output/translations/zh_CN/index.html
>
> Any comments are appreciated!
>
> V4 changes:
> 1, Add Harry's signed-off as he wants
>
> V3 changes:
> 1, fix a zh_CN/index.rst display issue
> 2, update .mailmap for zh_CN transolators'r email address
>
> V2 changes:
> 1, change the disclaimer file to Chinese version,
> 2, replace the obsolete translator's email address in related files.
> 3, fix couple of format issues in couple files
>
> Cheers!
> Alex
>
>
> Alex Shi (31):
>   docs/zh_CN: add disclaimer file
>   docs/zh_CN: move process related docs into process dir
>   docs/zh_CN: change Chinese index to know process dir
>   docs/zh_CN: add index file into process dir
>   docs/zh_CN: rename HOWTO into process directory
>   docs/zh_CN: howto format changes
>   docs/zh_CN: rename SubmittingPatches for html links
>   docs/zh_CN: format the submitting-patches doc to rst
>   docs/zh_CN: rename stable_kernel_rules doc
>   docs/zh_CN: rst format change for stable-kernel-rules
>   docs/zh_CN: rename email-clients.txt as email-clients.rst
>   docs/zh_CN: do rst format for email-clients.rst
>   docs/zh_CN: rename volatile-consider-harmful doc
>   docs/zh_CN: volatile doc format changes
>   docs/zh_CN: rename SubmittingDrivers
>   docs/zh_CN: format submitting drivers as rst
>   docs/zh_CN: rename magic-numbers as rst doc
>   docs/zh_CN: format the magic-number doc as rst
>   docs/zh_CN: rename stable_api_nonsense.txt as stable-api-nonsense.rst
>   docs/zh_CN: format stable-api-nonsense
>   docs/zh_CN: update Li Yang's email address
>   mailmap: update Li Yang's email address
>   docs/zh_CN: update Zhang Wei's email address
>   mailmap: update email address for Triplex
>   docs/zh_CN: update TripleX chung's email address
>   docs/zh_CN: fix rst format errors in howto.rst
>   docs/zh_CN: fix indent issue in stable-api-nonsense file
>   docs/zh_CN: fix indent issue in submitting-drivers
>   docs/zh_CN: fix rst format issue in submitting-patch
>   docs/zh_CN: remove zh-kernel.org in MAINTAINERS
>   mailmap: update my obsolete email address
>
>  .mailmap                                      |   6 +
>  .../translations/zh_CN/disclaimer-zh_CN.rst   |   9 ++
>  Documentation/translations/zh_CN/index.rst    |  17 +-
>  .../translations/zh_CN/magic-number.txt       | 153 ------------------
>  .../translations/zh_CN/oops-tracing.txt       |   2 +-
>  .../zh_CN/{ => process}/coding-style.rst      |   0
>  .../email-clients.rst}                        |  53 +++---
>  .../zh_CN/{HOWTO => process/howto.rst}        |  69 +++++---
>  .../translations/zh_CN/process/index.rst      |  53 ++++++
>  .../zh_CN/process/magic-number.rst            | 151 +++++++++++++++++
>  .../stable-api-nonsense.rst}                  |  67 ++++----
>  .../stable-kernel-rules.rst}                  |  32 ++--
>  .../submitting-drivers.rst}                   |  34 ++--
>  .../submitting-patches.rst}                   |  60 ++++---
>  .../volatile-considered-harmful.rst}          |  35 ++--
>  Documentation/translations/zh_CN/sparse.txt   |   6 +-
>  MAINTAINERS                                   |   1 -
>  17 files changed, 408 insertions(+), 340 deletions(-)
>  create mode 100644 Documentation/translations/zh_CN/disclaimer-zh_CN.rst
>  delete mode 100644 Documentation/translations/zh_CN/magic-number.txt
>  rename Documentation/translations/zh_CN/{ => process}/coding-style.rst (100%)
>  rename Documentation/translations/zh_CN/{email-clients.txt => process/email-clients.rst} (82%)
>  rename Documentation/translations/zh_CN/{HOWTO => process/howto.rst} (95%)
>  create mode 100644 Documentation/translations/zh_CN/process/index.rst
>  create mode 100644 Documentation/translations/zh_CN/process/magic-number.rst
>  rename Documentation/translations/zh_CN/{stable_api_nonsense.txt => process/stable-api-nonsense.rst} (80%)
>  rename Documentation/translations/zh_CN/{stable_kernel_rules.txt => process/stable-kernel-rules.rst} (76%)
>  rename Documentation/translations/zh_CN/{SubmittingDrivers => process/submitting-drivers.rst} (86%)
>  rename Documentation/translations/zh_CN/{SubmittingPatches => process/submitting-patches.rst} (92%)
>  rename Documentation/translations/zh_CN/{volatile-considered-harmful.txt => process/volatile-considered-harmful.rst} (81%)
>

