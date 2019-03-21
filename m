Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A105C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6771A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfCUUWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:22:46 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:54666 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbfCUUWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:22:46 -0400
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
From:   Meelis Roos <mroos@linux.ee>
Subject: CONFIG_DEBUG_VIRTUAL breaks boot on x86-32
Message-ID: <4d5ee3b0-6d47-a8df-a6b3-54b0fba66ed7@linux.ee>
Date:   Thu, 21 Mar 2019 22:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to debug another problem and turned on most debug options for memory.
The resulting kernel failed to boot.

Bisecting the configurations led to CONFIG_DEBUG_VIRTUAL - if I turned it on
in addition to some other debug options, the machine crashed with

kernel BUG at arch/x86/mm/physaddr.c:79!

Screenshot at http://kodu.ut.ee/~mroos/debug_virtual-boot-hang-1.jpg

The machine was Athlon XP with VIA KT600 chipset and 2G RAM.

-- 
Meelis Roos <mroos@linux.ee>
