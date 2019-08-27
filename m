Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EDCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC72A2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfH0DTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:19:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60357 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728345AbfH0DTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:19:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46HYyL5HWHz9sBF;
        Tue, 27 Aug 2019 13:19:38 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Hari Bathini <hbathini@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     mahesh@linux.vnet.ibm.com, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3] powerpc/fadump: sysfs for fadump memory reservation
In-Reply-To: <f8e9cbdd-1926-081d-c8e6-f9d55408fe51@linux.ibm.com>
References: <20190810175905.7761-1-sourabhjain@linux.ibm.com> <53311fa4-2cce-1eb6-1aae-0c835e06eb24@linux.ibm.com> <cf4fdb60-438c-bc4e-d759-1fbb27364c50@linux.ibm.com> <f53e4cfe-57cb-d8a6-385a-fa6243940573@linux.ibm.com> <f8e9cbdd-1926-081d-c8e6-f9d55408fe51@linux.ibm.com>
Date:   Tue, 27 Aug 2019 13:19:35 +1000
Message-ID: <87sgpn2t2w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hari Bathini <hbathini@linux.ibm.com> writes:
> On 26/08/19 4:14 PM, Sourabh Jain wrote:
>> On 8/26/19 3:46 PM, Sourabh Jain wrote:
>>> On 8/26/19 3:29 PM, Hari Bathini wrote:
>>>> On 10/08/19 11:29 PM, Sourabh Jain wrote:
>>>>> Add a sys interface to allow querying the memory reserved by
>>>>> fadump for saving the crash dump.
>>>>>
>>>>> Add an ABI doc entry for new sysfs interface.
>>>>>    - /sys/kernel/fadump_mem_reserved
>>>>>
>>>>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>>>> ---
>>>>> Changelog:
>>>>> v1 -> v2:
>>>>>   - Added ABI doc for new sysfs interface.
>>>>>
>>>>> v2 -> v3:
>>>>>   - Updated the ABI documentation.
>>>>> ---
>>>>>
>>>>>  Documentation/ABI/testing/sysfs-kernel-fadump    |  6 ++++++
>>>>
>>>> Shouldn't this be Documentation/ABI/testing/sysfs-kernel-fadump_mem_reserved?
>> 
>> How about documenting fadump_mem_reserved and other sysfs attributes suggested
>> by you in a single file Documentation/ABI/testing/sysfs-kernel-fadump?
>
> I wouldn't mind that but please do check if it is breaking a convention..

AIUI a file named like that would hold the documentation for the files
inside a directory called /sys/kernel/fadump.

And in fact that's probably where these files should live, rather than
just dropped directly into /sys/kernel.

cheers
