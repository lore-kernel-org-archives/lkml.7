Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ADC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4C72064B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dlink.ru header.i=@dlink.ru header.b="Etb4tzTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfLFLQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 06:16:52 -0500
Received: from fd.dlink.ru ([178.170.168.18]:47898 "EHLO fd.dlink.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfLFLQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:16:52 -0500
Received: by fd.dlink.ru (Postfix, from userid 5000)
        id 589DE1B21576; Fri,  6 Dec 2019 14:16:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru 589DE1B21576
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dlink.ru; s=mail;
        t=1575631008; bh=zIdiCpZ9XY3JaavuKzuAL4SRBQIiU9MNH/ZkKIXD2sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Etb4tzTiRapJgflytgB73OE15LbikSU+13GDwA3Qt0eurWvZLzN6Tix8V3Dc/GIQV
         al5zXWqDCI7TZNjq5Rki4L3wAUozoBAzxIdTzAmPUHSm/qMDTxqxLIrgOVC2TKjwA9
         jrMYtdctepzTrajZEoQ/ZPSRGx/gec3hzaCcD6tE=
Received: from mail.rzn.dlink.ru (mail.rzn.dlink.ru [178.170.168.13])
        by fd.dlink.ru (Postfix) with ESMTP id CC1A01B202CB;
        Fri,  6 Dec 2019 14:16:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 fd.dlink.ru CC1A01B202CB
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTP id 7F3241B22664;
        Fri,  6 Dec 2019 14:16:40 +0300 (MSK)
Received: from mail.rzn.dlink.ru (localhost [127.0.0.1])
        by mail.rzn.dlink.ru (Postfix) with ESMTPA;
        Fri,  6 Dec 2019 14:16:40 +0300 (MSK)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 06 Dec 2019 14:16:40 +0300
From:   Alexander Lobakin <alobakin@dlink.ru>
To:     Paul Burton <paulburton@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Tony Ambardar <itugrok@yahoo.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: BPF: Restore MIPS32 cBPF JIT; disable MIPS32 eBPF
 JIT
In-Reply-To: <20191205182318.2761605-1-paulburton@kernel.org>
References: <20191205182318.2761605-1-paulburton@kernel.org>
User-Agent: Roundcube Webmail/1.4.0
Message-ID: <84c74e399e854b3b17232cd605b6c9e9@dlink.ru>
X-Sender: alobakin@dlink.ru
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Burton wrote 05.12.2019 21:23:
> [...]

> Note that this does not undo the changes made to the eBPF JIT by that
> commit, since they are a useful starting point to providing MIPS32
> support - they're just not nearly complete.

BTW, would be very nice to see eBPF JIT support for not only MIPS32R2+,
but also pre-R2 CPUs in future.

> [...]

Regards,
ᚷ ᛖ ᚢ ᚦ ᚠ ᚱ
