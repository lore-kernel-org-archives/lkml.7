Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01291CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD3B2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="C3M3/y+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfJ2UhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:37:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37231 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbfJ2UhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:37:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so15127373wrv.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 13:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PRhnrmB+ijpIENLvNMWsjQXO/kOYcBONzviL0obRJs4=;
        b=C3M3/y+TLjza3wimeJs8rWciiXa7rodbQBbutdOXZ4IctymP0lddNtwy0FfkRLQV8i
         jJfta0vYJayfA2SejvZ+JRYtax+ltj47uFN11MTlMkbKiRvh6s2ycTgAPxmxB1ET+AUn
         s70mqMd96vtA5EUXDI2h6J24hL+W6jEhxLmZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRhnrmB+ijpIENLvNMWsjQXO/kOYcBONzviL0obRJs4=;
        b=QilTbv9Y5IV9ziHwFs4TaoL39WFXrXX+r7Mr7LLCGOGX75qrDUhXOv7Ie2T/nxrRk7
         cQD+e2j90/9/1mMpstFqtA83s/42GEk7BeZLgNA/cELsEEGuBMSBYKbbqyGMrVjGu9oB
         kZlaiJ3yR9ymCr07yP77lO6IjIg6DwfVzyX8zoOVSKQ8aDJbJI32zMPmHLnKTEKkmghe
         SIh2be8nT5gHIlGVPmaOPw4mODPck5SjnfiAO53PXsu1l8xm1wEJHQbzKmurEqX0p/u1
         NoIl8mXcEHW4iNrMb2Aa74lPlxk0zlAiPF57fqZa+c6BYCCEeUm2UWQTslBVr8I9p1it
         uAUA==
X-Gm-Message-State: APjAAAUZj/WBhQ5AMB0NPZkzt/yw4JwymjYi/VIBJ9NfgfO7W/E/dN1n
        PZJL5Cl+O5Sacy986JGewbjVrw==
X-Google-Smtp-Source: APXvYqyhQswqQqgTJESq7XubFPQxrrPAZjgc9H7Nt+m2PQZpI7MF2AzpUdj21gzzKwvdLpBK5/8YBg==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr22359046wrq.129.1572381434716;
        Tue, 29 Oct 2019 13:37:14 -0700 (PDT)
Received: from [192.168.1.149] (ip-5-186-115-54.cgn.fibianet.dk. [5.186.115.54])
        by smtp.gmail.com with ESMTPSA id 6sm5085121wmd.36.2019.10.29.13.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 13:37:14 -0700 (PDT)
Subject: Re: [PATCH 04/16] dyndbg: rename __verbose section to __dyndbg
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, Arnd Bergmann <arnd@arndb.de>,
        Jessica Yu <jeyu@kernel.org>, linux-arch@vger.kernel.org
References: <20191029200026.9790-1-jim.cromie@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <e9835376-1efe-1d1b-4a99-8bb920e04a08@rasmusvillemoes.dk>
Date:   Tue, 29 Oct 2019 21:37:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191029200026.9790-1-jim.cromie@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2019 21.00, Jim Cromie wrote:
> dyndbg populates its callsite info into __verbose section, change that
> to a more specific and descriptive name, __dyndbg.

Yeah, that has always bugged me. Ack to that part.

> Also, per checkpatch:
>   move extern struct _ddebug __(start|stop)__dyndbg[] to header file

Hm, why? checkpatch should often be ignored. Since we only refer to
those symbols in the .c file, there's no reason to pollute every other
translation unit with those declarations. Having declarations in a
header makes sense when the actual entity gets defined in some .c file
(which hopefully also includes the header). But these are defined by the
linker, so there's no type safety to be had.

>   simplify __attribute(..) to __section(__dyndbg) declaration.

Makes sense, since you're munching the thing anyway.

Rasmus
