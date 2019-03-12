Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C237C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C9214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfCLHWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:22:46 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:56787 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbfCLHWq (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Tue, 12 Mar 2019 03:22:46 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Tue, 12 Mar 2019 08:22:44 +0100
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.0+ merge window
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tony Luck <tony.luck@gmail.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1551940186.8289.60.camel@HansenPartnership.com>
 <CA+8MBb+MJhS9ejWQ0+vjDyhdnK5bsuaLPwpM5f-h1-6tHr4rVg@mail.gmail.com>
 <yq1ef7dqm6v.fsf@oracle.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <b4055c9e-8fc8-7585-908d-3dfac29ac915@suse.com>
Date:   Tue, 12 Mar 2019 08:22:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <yq1ef7dqm6v.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/19 7:51 PM, Martin K. Petersen wrote:
> 
> Tony,
> 
>> arch/ia64/hp/sim/simscsi.c: In function 'simscsi_interrupt':
>> arch/ia64/hp/sim/simscsi.c:108:51: error: 'struct scsi_cmnd' has no
>> member named 'serial_number'
> 
> I asked Hannes to fix this but he's been quiet for a few days. I guess
> I'll clean it up...
> 
Sorry. I'll send a patch shortly.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
