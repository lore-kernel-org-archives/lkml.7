Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBEA21872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfCOCVk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:21:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54471 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfCOCVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:21:40 -0400
Received: from [IPv6:2601:646:8680:2bb1:49f8:3263:ee83:1e43] ([IPv6:2601:646:8680:2bb1:49f8:3263:ee83:1e43])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2F2LGAs1377403
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 14 Mar 2019 19:21:18 -0700
Date:   Thu, 14 Mar 2019 19:21:07 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CACJDEmpKxL=c-1zeBYR6v4JK=QN3vxd967HwBFHhTWmxPQhM4A@mail.gmail.com>
References: <20190311150423.15979-1-ross.philipson@oracle.com> <20190311150423.15979-2-ross.philipson@oracle.com> <018B6986-0C7F-4C76-88ED-1548BC77E5AA@zytor.com> <CACJDEmpKxL=c-1zeBYR6v4JK=QN3vxd967HwBFHhTWmxPQhM4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 1/1] x86: Secure Launch boot protocol
To:     Konrad Rzeszutek Wilk <konrad@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        X86 <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        corbet@lwn.net, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        kanth.ghatraju@oracle.com, Daniel Kiper <daniel.kiper@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        dpsmith@apertussolutions.com,
        Ross John Philipson <ross.philipson@oracle.com>
From:   hpa@zytor.com
Message-ID: <09FA3C31-BFC5-41FA-AB17-87E45EE2FB9B@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 14, 2019 11:53:18 AM PDT, Konrad Rzeszutek Wilk <konrad@kernel.org> wrote:
>.. snip..
>>
>> Double NAK – I'm in a meeting right now but with clarify shortly.
>
>Would it help if we had a meeting to brainstorm an acceptable solution?
>Thank you.

It would. I'll write up the immediate issues (which are trivial – just some misunderstanding of the boot protocol. I just wanted to make sure it didn't get merged and possibly get set in stone) later tonight, but it would be great to talk about underlying issues.

Do I remember right that you are on the east coast, or am I full of it.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
