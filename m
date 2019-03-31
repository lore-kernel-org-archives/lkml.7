Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7907C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409521841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014474;
	bh=5AWBjoXVkY5mv1rS6MQyAMNT8QUdmbj8uHbUCB4mT9k=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=l2uZ57NKif7PWyu0c3TnzgU8Hw5rSHWS1Yj1shpP/40BYaP0CtXm7Xo3DsZSBSWU/
	 b4EOQMxuf68rDbslYryhw3eS3RxnKTwhcYSqD3pj/dNtOSlQtM8P8Wtlk0ngLosFOb
	 472EtPfkPOdN4dxUiL0mMJ9LjVcVdLHj5b+aYh5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfCaGlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:13 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43913 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731065AbfCaGlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:10 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2969898pfd.10;
        Sat, 30 Mar 2019 23:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=CPqUPTdNgEcRoZ3wIRsuNUZ898kksJJ5er6ojLvDhuU=;
        b=sswaWge+3fCbn92EgxtmSmjhAZDxsEvevs3Bi5/ynBidfEgy7Em4ncpZjpVVhLVcn6
         zCWCeMuJCRHVHIwcKcq5PCeJlPDygHN9ZdFlCL45626loqXl6ALNbVc7XfCM5r9TTKso
         jJXnmi/y1rKOeDs/9EKVFBKKuzpLaN/fgohcAMsQ2rAP4aTF8tB8bILdeX16H4uBi4Oq
         CFl+rRcjftUurECbvF2f3b13QWIXaubLyEubN/uXcVw6Dx3Kzb6a/tRdvL7sVvTl2EEw
         YDCUbxBUChj/6/3ExByPe7CiuD2TANgQ1qQWgneABbrY1ihH6c4Mee1RGsn1Q0WPbPOZ
         j/iQ==
X-Gm-Message-State: APjAAAU15BCFqKGUsdFJEQJnwFkV6nIgKdKaTvX5RsOp11RWYCp9/IR9
        dzgNxkB1I4GeYtY7cn4JlQ==
X-Google-Smtp-Source: APXvYqweSMhiKbtyvu7/T8SUeEBNWFPOA/cV2kaiAMCt2UVFfGaCu78V3qxutq3ch8QKgQYzsrmcGA==
X-Received: by 2002:a63:4750:: with SMTP id w16mr55542337pgk.256.1554014469909;
        Sat, 30 Mar 2019 23:41:09 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id a17sm10219672pfj.123.2019.03.30.23.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:09 -0700 (PDT)
Message-ID: <5ca06105.1c69fb81.8e827.7f26@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:07 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: Add vendor prefix for novatek
References: <20190321135955.25661-1-jagan@amarulasolutions.com> <20190321135955.25661-2-jagan@amarulasolutions.com>
In-Reply-To: <20190321135955.25661-2-jagan@amarulasolutions.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Ryan Pannell <ryan@osukl.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        devicetree@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 19:29:52 +0530, Jagan Teki wrote:
> Add vendor prefix for novatek.
> 
> Novatek Microelectronics Corp. is a leading fabless chip design
> company specializing in the design, development and sales of a
> wide range of display driver ICs & SoC solutions.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

