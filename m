Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3BBC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB30D21D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576051477;
	bh=B1Z2ZdmadE/uwSr7tP3e+eWCAuxvdqiIy995PRO7DnQ=;
	h=Date:In-Reply-To:References:Subject:To:CC:From:List-ID:From;
	b=bENkGG+XwxRXEby5NVmHoJ4cAF925mNshq9P47ZsstrN5QOlUTUlKi3aJej3ZSckU
	 AnWAIc0lm/7g7dqIic8lDWpO6ByavMT+kZ/0vFJRI6mwh7bGOb6s2UB/B9TCheqIe6
	 5OlNtGgBahLPLYGIaOXB1+3cD1a9ip1kawDpa6ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbfLKIEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 03:04:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbfLKIEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 03:04:36 -0500
Received: from [10.228.163.158] (unknown [2.55.135.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D38B2173E;
        Wed, 11 Dec 2019 08:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576051476;
        bh=B1Z2ZdmadE/uwSr7tP3e+eWCAuxvdqiIy995PRO7DnQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=sdVbIBaYyIIc8OK1sQiHd65Y9ChIPY3/OpofxyRTEaxO/bPYp8FqUdiVrguQFQFC3
         kMRQ6zy6hAkcv/CJWicRC5ceOpDPU40tYN+3gohr0toChexW0teHTP/NhAegW7Vzb2
         seiDATUX+pMqRUC4qD7OxXY32t/dTiZ2Hyn/GAMg=
Date:   Wed, 11 Dec 2019 10:04:29 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20191210.232556.198185739663319799.davem@davemloft.net>
References: <20191124085720.6201-1-rppt@kernel.org> <20191211062649.GA28255@rapoport-lnx> <20191210.232556.198185739663319799.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sparc64: add support for folded p4d page tables
To:     David Miller <davem@davemloft.net>
CC:     sparclinux@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rppt@linux.ibm.com
From:   Mike Rapoport <rppt@kernel.org>
Message-ID: <4C87F045-7902-415E-BE54-9F527CE3B5E6@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 11, 2019 9:25:56 AM GMT+02:00, David Miller <davem@davemloft=2E=
net> wrote:
>From: Mike Rapoport <rppt@kernel=2Eorg>
>Date: Wed, 11 Dec 2019 08:26:51 +0200
>
>> Any updates on this?
>
>I thought I gave my ack, sorry:
>
>Acked-by: David S=2E Miller <davem@davemloft=2Enet>

Can you please take it via sparc tree?

--=20
Sincerely yours,
Mike
