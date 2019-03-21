Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E8CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E6A218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 20:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfCUUZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 16:25:19 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:54675 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728093AbfCUUZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 16:25:19 -0400
Subject: powerpc32 boot crash in 5.1-rc1
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <91966c00-b09f-7e07-89cb-04ac208d5dc1@linux.ee>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <67399e37-6c8b-7172-09ed-be9e1bf4429c@linux.ee>
Date:   Thu, 21 Mar 2019 22:25:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <91966c00-b09f-7e07-89cb-04ac208d5dc1@linux.ee>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While 5.0.0 worked fine on my PowerMac G4, 5.0 + git (unknown rev as of Mar 13),
5.0.0-11520-gf261c4e and todays git all fail to boot.

The problem seems to be in page fault handler in load_elf_binary() of init process.

Two different screenshots are at http://kodu.ut.ee/~mroos/powerpc-boot-hang-1.jpg and
http://kodu.ut.ee/~mroos/powerpc-boot-hang-1.jpg .

-- 
Meelis Roos <mroos@linux.ee>
