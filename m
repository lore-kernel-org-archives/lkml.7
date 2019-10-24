Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC6ACA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135922166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 05:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571893509;
	bh=gJ/EKDiWsyHKaqbWGzDjLkKpfS2PCdHGvPf4JF5qzMA=;
	h=Date:From:To:CC:CC:Subject:References:In-Reply-To:List-ID:From;
	b=fP8vBwLx80hSTrW0B4VxiUgZgTCyrUwELaqf24wfTKk9mtp+jztEnPv5tDr0Afr4/
	 wS905FCaYuAUc7voKiCMdiVp8AlHx95UR2Ge+f8FBCPWhazGhTkR6Ya6NeClAkx3jm
	 iekvfWkbeelb66Dk5mfe9gnJghB79lAswCI+nBbQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437448AbfJXFFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 01:05:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45333 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfJXFFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 01:05:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id r1so13464610pgj.12;
        Wed, 23 Oct 2019 22:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:subject:references
         :in-reply-to;
        bh=G+f5MPws5w1xb4+khTasH/MQ2+uZ0KNewuOhaLIpsww=;
        b=Dr3bnTk8rnjcUeaYarJDwAErTuX9yRxbDM5RbAlbUUj9E8R2SVOy+JnHnpoHmihlQ9
         M312EEHisbwStpTesq+CDapLURWyiOtCcEAzBiiJIe6zbGo2dM4Cyh+ASJNOeJUSMI6Z
         xzjbBzx0Lc2cnWb6geQGT079SNHWbO03OoxtL2NwMRJaImgsqsiVGclV/lrTZmD0ufaE
         Ef8sgSCZXAXhDLKm7VEert5gJquCjch9rPbrSvRObA+jB758kT+ttmlAWEfR2v3GEQH9
         guqF2kzpitYbXum/lVHu9Vt3nhQkMkZ/dyAkn7QH/rCz1BDlHT0ikIuJoqvAYhA7CDlM
         WUIA==
X-Gm-Message-State: APjAAAUrqsmDcCNpwObtJR0A8YRZ6WxWRVOIiT3I+0jGcKc2DK7Pdft/
        vBmh0lb3XBrHxGgM8twqHjI=
X-Google-Smtp-Source: APXvYqyDtRl0L6anMSVVkm+9vOzgcwuMwgxtp4NPNVgz8PfjTaOKac5Cew56HQ+sw7L21FEQ9r8aHw==
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr4731443pjv.73.1571893506599;
        Wed, 23 Oct 2019 22:05:06 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:5cfa:8da3:1021:be72])
        by smtp.gmail.com with ESMTPSA id e184sm26235280pfa.87.2019.10.23.22.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 22:05:06 -0700 (PDT)
Message-ID: <5db13102.1c69fb81.21bba.4852@mx.google.com>
Date:   Wed, 23 Oct 2019 22:05:05 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: include: remove unsued header file asm/sgi/sgi.h
References:  <20191022130919.18582-1-tbogendoerfer@suse.de>
In-Reply-To:  <20191022130919.18582-1-tbogendoerfer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> asm/sgi/sgi.h is unused, time to remove it.

Applied to mips-next.

> commit 2409839ab6bf
> https://git.kernel.org/mips/c/2409839ab6bf
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
