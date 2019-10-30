Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23253CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC86520874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfJ3I6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:58:04 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:51365 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbfJ3I6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:58:03 -0400
Received: from [10.17.212.211] (unknown [195.37.61.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 50FA820225AEB;
        Wed, 30 Oct 2019 09:58:00 +0100 (CET)
Subject: Re: load_uefi_certs: Couldn't get size: 0x800000000000000e
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Josh Boyer <jwboyer@fedoraproject.org>
Cc:     linux-security-module@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3f48aab2-7d8e-ee9b-c362-3b7f84609abe@molgen.mpg.de>
Message-ID: <b22a8c89-c843-f688-a723-df93430b6382@molgen.mpg.de>
Date:   Wed, 30 Oct 2019 09:57:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3f48aab2-7d8e-ee9b-c362-3b7f84609abe@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Josh,


On 04.10.19 14:24, Paul Menzel wrote:

> On a Dell Latitude E7250 with a self-built Linux 5.4-rc1 the error message
> below is printed on the screen.
> 
>      [    0.658664] Couldn't get size: 0x800000000000000e
> 
> Here are the message from the ring buffer (`dmesg`).
> 
> ```
> [    0.658329] calling  load_uefi_certs+0x0/0x217 @ 1
> [    0.658472] integrity: Loading X.509 certificate: UEFI:db
> [    0.658544] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
> [    0.658545] integrity: Loading X.509 certificate: UEFI:db
> [    0.658606] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
> [    0.658664] Couldn't get size: 0x800000000000000e
> [    0.658689] Couldn't get UEFI MokListRT
> [    0.658768] initcall load_uefi_certs+0x0/0x217 returned 0 after 426 usecs
> ```
> 
> Could this error message be improved, to give the user a hint, what is wrong,
> what the consequences are, and what should be done?
> 
> Should the message below be `pr_error`, and the other error debug?
> 
>      pr_info("Couldn't get UEFI MokListRT\n");
> 
> Please find the Linux messages and (`make savedefconfig`) configuration
> attached.
> 
> Do you know more about the reason, and if the Linux code can handle it more
> gracefully?
> 
> Commit 15ea0e1e (efi: Import certificates from UEFI Secure Boot) was already
> added in Linux 5.0, and I do not remember seeing it with Debian’s default
> Linux kernel. No idea, what is configured differently, or I just missed it.

I am still getting this with Linux 5.4-rc5.


Kind regards,

Paul
