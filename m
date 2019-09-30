Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD0B8C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8172220815
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 15:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JXpc/5HW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732002AbfI3P2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 11:28:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51862 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbfI3P2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 11:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SR36eAXn6tsu3lDOH6AbvvqfE8WVsaSDMysCUnlEijg=; b=JXpc/5HW48o0GU9HxeSBelFTI
        pCLWZE7bhFrbMog+qIpxi3LLElE1ah/5A2yV6IcirW4q8GJR6SODjwzFx4ASgOxtBMm5HiTqb66/h
        moI6nlQboIV7fKF15uRa/543fasCXP9efTAf6I8X1Y68qGdkIYcCheHNHE5K2s/8asGDFW/+enClA
        dKPiY5TxSZpPo3Uu9Agzpa2luhz82OelrpmEirPnYAh5GvCHHv83m1t1R3s10/5k5J5HNOckCq9hV
        1hz5YRU4XTvFFhP581xC+8FdAIiJ/5W+9Y7O2xaB9AGUnfUxbIw6cI77x0BDTh3arbpwuHh4YWtdR
        gDQpwjfQg==;
Received: from [2601:1c0:6280:3f0::9a1f]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iExat-0004jy-6x; Mon, 30 Sep 2019 15:28:11 +0000
Subject: Re: [GIT PULL] remove dead mutt url and add active mutt url
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
References: <20190928151300.GA18122@debian> <20190930081310.7e3b9c52@lwn.net>
 <20190930152607.GA27688@Slackware>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a1d80b29-4cd8-2ffc-1b55-3a806fca1a06@infradead.org>
Date:   Mon, 30 Sep 2019 08:28:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190930152607.GA27688@Slackware>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/19 8:26 AM, Bhaskar Chowdhury wrote:
> On 08:13 Mon 30 Sep 2019, Jonathan Corbet wrote:
>> On Sat, 28 Sep 2019 20:43:03 +0530
>> Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>>
>>> The following changes since commit 4e4327891fe2a2a4db342985bff4d4c48703c707:
>>>
>>>   replace dead mutt url with active one. (2019-09-28 20:11:00 +0530)
>>>
>>>   are available in the Git repository at:
>>
>> Bhaskar, I'm not going to take a pull request for a change like this.  If
>> you would like to make this change (and it seems like a useful change to
>> make), please send me a patch that is:
>>
>> - based on docs-next
> I have no clue where do I found out "docs-next" Jon. But I have
> stumbled over these places..
> 
> https://github.com/torvalds/linux/commit/81a84ad3cb5711cec79f4dd53a4ce026b092c432
> 
> and this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdunlap/linux-docs.git/
> 
> Now, do you want me to make changes there and sent a patch?? I am
> absolutely not sure .
> 
> Kindly shed some light.
>> - properly changelogged
>> - demonstrated to build properly with sphinx
>>
>> Thanks,
>>
>> jon
> 
> Thanks,
> Bhaskar

Hi,
The kernel MAINTAINERS file says:

DOCUMENTATION
M:	Jonathan Corbet <corbet@lwn.net>
L:	linux-doc@vger.kernel.org
S:	Maintained
F:	Documentation/
F:	scripts/documentation-file-ref-check
F:	scripts/kernel-doc
F:	scripts/sphinx-pre-install
X:	Documentation/ABI/
X:	Documentation/firmware-guide/acpi/
X:	Documentation/devicetree/
X:	Documentation/i2c/
X:	Documentation/media/
X:	Documentation/power/
X:	Documentation/spi/
T:	git git://git.lwn.net/linux.git docs-next

that ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


-- 
~Randy
