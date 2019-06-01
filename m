Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB39EC28CC1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C42A27140
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 09:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfFAJTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 05:19:51 -0400
Received: from www74.your-server.de ([213.133.104.74]:59318 "EHLO
        www74.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfFAJTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 05:19:51 -0400
X-Greylist: delayed 1721 seconds by postgrey-1.27 at vger.kernel.org; Sat, 01 Jun 2019 05:19:50 EDT
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www74.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1hWzjE-0004z7-8O; Sat, 01 Jun 2019 10:51:04 +0200
Received: from [95.91.33.208] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <klaus.kusche@computerix.info>)
        id 1hWzjD-0007Qr-RS; Sat, 01 Jun 2019 10:51:03 +0200
To:     keescook@chromium.org, johannes.hirte@datenkhaos.de
From:   Klaus Kusche <klaus.kusche@computerix.info>
Cc:     bp@suse.de, samitolvanen@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
Message-ID: <e76e3384-702e-e0f6-c949-79beaca2a109@computerix.info>
Date:   Sat, 1 Jun 2019 10:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: klaus.kusche@computerix.info
X-Virus-Scanned: Clear (ClamAV 0.100.3/25467/Sat Jun  1 10:00:07 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

same problem here.

gcc version 9.1.0 (Gentoo 9.1.0 p1.0)
linux-5.1.6

RELOCS  arch/x86/boot/compressed/vmlinux.relocs
Invalid absolute R_X86_64_32S relocation: _etext
make[2]: *** [arch/x86/boot/compressed/Makefile:130: arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[2]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[2]: *** Waiting for unfinished jobs....

make clean or make distclean did *not* help.

-- 
Prof. Dr. Klaus Kusche
Private address: Rosenberg 41, 07546 Gera, Germany
+49 365 20413058 klaus.kusche@computerix.info https://www.computerix.info
Office address: DHGE Gera, Weg der Freundschaft 4, 07546 Gera, Germany
+49 365 4341 306 klaus.kusche@dhge.de https://www.dhge.de
