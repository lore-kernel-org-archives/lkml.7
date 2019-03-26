Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C4C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022AA2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbfCZPLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbfCZPLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:11:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 447EC3092666;
        Tue, 26 Mar 2019 15:11:55 +0000 (UTC)
Received: from [10.18.17.208] (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C76E2949B;
        Tue, 26 Mar 2019 15:11:53 +0000 (UTC)
Subject: Re: tools bugs: make clean deletes files in the git tree
To:     Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
References: <5ad376c1-c998-c0a0-9f47-af5f3ab26e35@intel.com>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <e2acad2c-9e2c-148a-ab62-f6882df77d3d@redhat.com>
Date:   Tue, 26 Mar 2019 11:11:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <5ad376c1-c998-c0a0-9f47-af5f3ab26e35@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 26 Mar 2019 15:11:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 4:45 AM, Adrian Hunter wrote:
> Hi
> 
> Doing:
> 
> 	make -C tools clean
> 
> Results in:
> 
> 	git diff --stat
> 	 tools/pci/pcitest.sh                                  |  72 ----------------
> 	 tools/testing/selftests/livepatch/test-callbacks.sh   | 587 ----------------------------------------------------------------------------------------------------------------------------
> 	 tools/testing/selftests/livepatch/test-livepatch.sh   | 168 ------------------------------------
> 	 tools/testing/selftests/livepatch/test-shadow-vars.sh |  60 -------------
> 	 4 files changed, 887 deletions(-)
> 
> i.e. 'make clean' seems to be deleting files that are in the git tree.
> 
> Regards
> Adrian
> 

Hi Adrian -- thanks for the report.  I will fixup the livepatch 
selftests Makefile and post a patch shortly.

-- Joe
