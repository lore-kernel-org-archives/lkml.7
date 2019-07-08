Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF51C48BE3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D367820693
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 01:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfGHBUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 21:20:06 -0400
Received: from ozlabs.org ([203.11.71.1]:39415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfGHBTm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 21:19:42 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 45hng02jdlz9sNf; Mon,  8 Jul 2019 11:19:40 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 4128a89ac80d3714babde5b2811ffd058b09c229
In-Reply-To: <04852442b540e73be0a20e13f69ab8427fd102e0.1560494348.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, oss@buserror.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/10] powerpc/8xx: move CPM1 related files from sysdev/ to platforms/8xx
Message-Id: <45hng02jdlz9sNf@ozlabs.org>
Date:   Mon,  8 Jul 2019 11:19:40 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 06:41:38 UTC, Christophe Leroy wrote:
> Only 8xx selects CPM1 and related CONFIG options are already
> in platforms/8xx/Kconfig
> 
> Move the related C files to platforms/8xx/.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4128a89ac80d3714babde5b2811ffd058b09c229

cheers
