Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22014C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA62720823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="R8tjEqBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbfCZHAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:00:23 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39872 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZHAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:00:23 -0400
Received: by mail-lj1-f194.google.com with SMTP id l7so10088397ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwDGgh1q8PbsvJzaj1vM4XiSlOQcgbvBNskRAQ9jqEM=;
        b=R8tjEqBXSWkhejbso5EWUc3LOtGmZOLmplb3QlrFyF7nKss4rgNQMF/dI4vZ/SqYU9
         5v2A86TPGOX/Q1Tq3rIlgIOSAyGcWqsGZXgwPKTUyCFqMGze1RHiAS/6JkyCiDrOABs6
         K2Cggm8vyMzeyCqex16ceFUxVR7Aub4t5oCDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwDGgh1q8PbsvJzaj1vM4XiSlOQcgbvBNskRAQ9jqEM=;
        b=SNkOQ4H+IK6Kfc3/6TEipR5n3/e4pq/pmwLppl1wVv9yxCP3hCJZHHNxCZHkNVM42E
         47e7dbhvx6HwhUTH0EnFw9qrUhUdGWgkRgZLRu7AmdnQNAb+PWJMpp/3DE/1JriQFBO2
         BgESIxxrvtj+Y4k0StgBAItyMl6rQ9ajidtohMvJ53TRi3qgcsnzrXFNYeCm1Jln4O3T
         4JLSTTJ0pBepl/Fj1TW1NLik4XvfApAqsk2WsjEiUQk43jrvaPZplLe0vGlzVogSeztx
         36Rygs+egLvx+x+vIa88os/I2ZZPeHjeS/8RikIV1B/dvEuPgWgNuXSIwCnGjyxZrW5Z
         l2hg==
X-Gm-Message-State: APjAAAVTAV6XRWPGMPLh3nDQ61YprCYcdZjGLpAxSIdOwjxa8LrTGTjV
        2GK2ydzmfpCG5oA5EuVjtgVmig==
X-Google-Smtp-Source: APXvYqz19XbRdw1kdYYxbQl2nNbaF6nYSJv0C5E6ArXNk1Gl8QKOIjU2kJHm+6xMtw4TGODxdqeoOw==
X-Received: by 2002:a2e:420c:: with SMTP id p12mr13021353lja.1.1553583621205;
        Tue, 26 Mar 2019 00:00:21 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w3sm2748520lji.59.2019.03.26.00.00.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 00:00:20 -0700 (PDT)
Subject: Re: [PATCH] Change in comment for the list_empty() routine.
To:     "Nitin U. Yewale" <nyewale@redhat.com>, airlied@linux.ie,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Cc:     loberman@redhat.com
References: <20190326062103.6775-1-nyewale@redhat.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <0230b95a-d5d4-5f0b-c880-b27895811bcb@rasmusvillemoes.dk>
Date:   Tue, 26 Mar 2019 08:00:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190326062103.6775-1-nyewale@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 07.21, Nitin U. Yewale wrote:
> Hello,
> 
> In one of the observations it was noticed that list_empty() routine
> returns true when the list is empty (head->next == head) OR False
> otherwise. Hence the proposed patch.

Hm, does anything use that file? It's almost impossible to have a
translation unit that doesn't end up including linux/types.h since
struct list_head is embedded in so many other structs. So if the
nvif/list.h was also included by anything, I'd expect an immediate build
failure (error: redefinition of ‘struct list_head’). Also, nothing under
drivers/gpu does a #include of a list.h file that is not linux/list.h.

IOW, I suggest deleting drivers/gpu/drm/nouveau/include/nvif/list.h
entirely.

Rasmus
