Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35FA2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 23:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfCKXeb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 19:34:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40839 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbfCKXeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 19:34:31 -0400
Received: from [IPv6:2607:fb90:8439:462:c89:253d:a93d:79fe] ([IPv6:2607:fb90:8439:462:c89:253d:a93d:79fe])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2BNY6UN4162945
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 11 Mar 2019 16:34:07 -0700
Date:   Mon, 11 Mar 2019 16:34:03 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <D3212816-1FE7-44B3-9CF6-299EF830BC0A@oracle.com>
References: <20190308114310.25041-1-jgross@suse.com> <D3212816-1FE7-44B3-9CF6-299EF830BC0A@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] doc: add boot protocol 2.13 description to Documentation/x86/boot.txt
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
CC:     x86@kernel.org, corbet@lwn.net, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, mfleming@suse.com, ross.philipson@oracle.com,
        daniel.kiper@oracle.com
From:   hpa@zytor.com
Message-ID: <01C7E686-048A-4DA8-BD42-DB95C25449D1@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 8, 2019 5:12:57 AM PST, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com> wrote:
>
>
>On March 8, 2019 6:43:10 AM EST, Juergen Gross <jgross@suse.com> wrote:
>>Documentation/x86/boot.txt is missing protocol 2.13 description.
>>
>>Signed-off-by: Juergen Gross <jgross@suse.com>
>
>You forgot Reported-by: Ross Philipson ...
>
>And pls feel free to add Reviewed-by from me as well.
>>---
>> Documentation/x86/boot.txt | 4 ++++
>> 1 file changed, 4 insertions(+)
>>
>>diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
>>index f4c2a97bfdbd..223e484a1304 100644
>>--- a/Documentation/x86/boot.txt
>>+++ b/Documentation/x86/boot.txt
>>@@ -61,6 +61,10 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags
>>field and extension fields
>> 		to struct boot_params for loading bzImage and ramdisk
>> 		above 4G in 64bit.
>> 
>>+Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set
>in
>>+		xloadflags to support booting a 64-bit kernel from 32-bit
>>+		EFI
>>+
>> **** MEMORY LAYOUT
>> 
>> The traditional memory map for the kernel loader, used for Image or

Add my Reviewed-by: too.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
