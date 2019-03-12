Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8874C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FCCC205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552416176;
	bh=mdDvoojjODlrZuVeLYKpkYHCEmlcWUCmKYznRpaUn5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2IjHaGiikv37c4t/OyY0LAVtXtzdjkN2bWS2F7km2or2EMJYM7AStKDdTWuP1fUrW
	 2EIgPzIOZJjGIF0Xo/wHSDaFchgIxoqKFwXZ9uuBF+N+ztkpXUYhO/O4TuIRDy+wih
	 L+G3tg74b3h9Ftsadah4wenQcFBSqKMr67SCulIE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfCLSmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:42:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39109 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfCLSmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:42:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id e15so3456079otk.6;
        Tue, 12 Mar 2019 11:42:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uAUQnioVC46pCTtiM5rsLrIReO2nGYI3AaxW1WGJlpg=;
        b=nw6S0aOtehPdv5wqm1esRidDAP99M71HsjVZria1xnx7Zb4lQbmzXPx07mjsnyoNJH
         FSNWvToZdV8H7rjAR8FvSkmw5nc8vFw1eFON4n5dDru2yC95uVG7vhLjVxzfUZRcjxks
         Fmd1bSyGr3Mgtvrg980Puft548iuZ4FhELHGhctmZzidSzTWrykb1dlpTD0hiT2oiLoF
         EODoapLN7j3VwZ3aomZHsKDC3tQdjXb/jbseOmDKq3nrckdFrFMSeAlk0jtkNR5yWcXJ
         GvQu49f4yhRinsk739I9GnnPAR0DoY3B/YNLZARguh0dSNCtm7XkbvCpXXxZtZ8O3V6E
         SbFA==
X-Gm-Message-State: APjAAAUDDSKcJgjFZJ2W7iL2aWffIOsTFE2svB+m+vnwtJ7zwCoeSl5A
        5m2tJRd1CzGdBeY8S1dqYw==
X-Google-Smtp-Source: APXvYqxrq6Zut3N0FAMEqMhNlPyFWW5rXxB55A0nk6XtlDuIQlu4zWg/pbvFhUT89m9isL+sVEq4Nw==
X-Received: by 2002:a9d:de4:: with SMTP id 91mr1303920ots.5.1552416173774;
        Tue, 12 Mar 2019 11:42:53 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm3632596otf.73.2019.03.12.11.42.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:42:53 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:42:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v2 3/5] dt-bindings: display: armada: Improve the LCDC
 documentation
Message-ID: <20190312184252.GA12611@bogus>
References: <20190304202006.3863-1-lkundrak@v3.sk>
 <20190304202006.3863-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304202006.3863-4-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 21:20:04 +0100, Lubomir Rintel wrote:
> The port is a child, not a property. And should be accompanied by an
> example. Plus a pair of cosmetic changes that don't seem to deserve a
> separate commit.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v1:
> - Minor adjustments to the commit message wording.
> 
>  .../bindings/display/marvell,armada-lcdc.txt     | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
