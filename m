Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D036C76186
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E8A206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d4SLeKg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfG2Umt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:42:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33082 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfG2Umt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:42:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id f20so19600860pgj.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4IbBEME7exZuIIcITVOJ5zO3Z5Z1Hrse/4bQ5Tx6U+4=;
        b=d4SLeKg//BxgFqj7SlUfgmPEMOo3fxt1QqKVXfdwLe5tz1aUDjPrAJHhc6EijrtVfI
         TxKpH9fzR79EjAsHa55/1dRc5Lw2LyjbC2uJNoibzGKRPvsPRvOdXhFSFmXMoTRbTXN6
         dIBVAUZ4sGoM0wcW6tr1BVkbOfjj82o4NTXPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4IbBEME7exZuIIcITVOJ5zO3Z5Z1Hrse/4bQ5Tx6U+4=;
        b=oEtkV2s1qzURKIb3v+qeyVmWii3cfa1Fca7i/vODk43qpCdpZDiy4JCQuwQvhQSF7P
         S5Z9jLK/gJH9cUN7rCDp9EyMJYJuz40AfXLnfb+pXE3KTP2XAuQJK/rWaAqaNuQ0RS61
         gTxxJp/1TP76GnVUxKBCocpEy4kwk7qJEnQNxMTS+Vp0ZsbHI8DRqlA2PjgX83ez6B7z
         F97kmCLLlnk8eLSGsHjfobIjDJT4T5nW3UTTaZxpvOFw48zRveI2BN4EzRowqCaEB/oL
         n+IPwUe2wJZ2tboXNnats3WVQObBxT1lzTKzsGD+yGW4BZhPFBJCHy7xpTE+eAsgGCKo
         AbQA==
X-Gm-Message-State: APjAAAXKqArEx1su+D8SL7XbF35/1iWVq+czmmtjCIIebJHgmpIlBOK2
        jqj9N8OaZITOZKTO/4c6RdoNQw==
X-Google-Smtp-Source: APXvYqz73uoB6vT4B44y2rcFB3vxiCRIJaVenmtKpJoufizwlbNp35AwfnWY1R651Mk9fugrEp/h2g==
X-Received: by 2002:a62:2c8e:: with SMTP id s136mr38877905pfs.3.1564432968701;
        Mon, 29 Jul 2019 13:42:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y11sm65242995pfb.119.2019.07.29.13.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:42:48 -0700 (PDT)
Date:   Mon, 29 Jul 2019 13:42:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: Kernel patch commit message and content do differ
Message-ID: <20190729204242.GG250418@google.com>
References: <ca2abaa5-c478-0b9f-cd51-c60aa032835f@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca2abaa5-c478-0b9f-cd51-c60aa032835f@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 29, 2019 at 10:20:25PM +0200, Toralf Förster wrote:
> May I ask you to clarify why
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/diff/queue-5.2/net-ipv4-fib_trie-avoid-cryptic-ternary-expressions.patch?id=e1b76013997246a0d14b7443acbb393577d2a1e8
> speaks about a ternary operator, whereas the diff shows a changed
> #define?

This is a good question, apparently the content of the queued patch is:

commit 4df607cc6fe8e46b258ff2a53d0a60ca3008ffc7
Author: Nathan Huckleberry <nhuck@google.com>
Date:   Mon Jun 17 10:28:29 2019 -0700

    kbuild: Remove unnecessary -Wno-unused-value


however the commit message is from:

commit 25cec756891e8733433efea63b2254ddc93aa5cc
Author: Matthias Kaehlcke <mka@chromium.org>
Date:   Tue Jun 18 14:14:40 2019 -0700

    net/ipv4: fib_trie: Avoid cryptic ternary expressions


Other than that the stable port also is missing a Signed-off-by tag
from Nathan.

Looks like the patch didn't actually make it into -stable yet? If that
is correct we should be in time to fix it up before it becomes part of
the git history.
