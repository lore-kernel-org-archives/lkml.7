Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C99CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66748213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfCVOV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:21:58 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:33122 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbfCVOV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:21:57 -0400
Subject: Re: powerpc32 boot crash in 5.1-rc1
To:     LEROY Christophe <christophe.leroy@c-s.fr>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20190321221632.Horde.sUFPCFV5Nrk0KQFVNqmMjw2@messagerie.si.c-s.fr>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <6c3bfa43-4b11-ab27-fcc6-3732ccbed304@linux.ee>
Date:   Fri, 22 Mar 2019 16:21:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190321221632.Horde.sUFPCFV5Nrk0KQFVNqmMjw2@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> While 5.0.0 worked fine on my PowerMac G4, 5.0 + git (unknown rev as of Mar 13), 5.0.0-11520-gf261c4e and todays git all fail to boot.
>>
>> The problem seems to be in page fault handler in load_elf_binary() of init process.
> 
> The patch at https://patchwork.ozlabs.org/patch/1053385/ should fix it

Tested it - yes, it fixes the boot.

-- 
Meelis Roos <mroos@linux.ee>
