Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A5EC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415182186D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574098785;
	bh=MRM5RHb+Yf97fkotyX8TPz/CS98nnZY3aF5arwgMVow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I4PKmt1AfkQKAA4EFJverqs45X1IL0Axps3ZKLZNQk72TDageY8/+wAkOhK6uSYQw
	 osGSpandAGoE1z06+lWCx5sFbj9D5kLrgFWD7F3/cvC7nh8fgo3fUTnbPTtDc5chig
	 8hlZ3YUN0pV4GJyD/zMsaGJbD2NltR+4LYWW3XX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbfKRRjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:39:44 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41741 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKRRjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:39:44 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so15245151oty.8;
        Mon, 18 Nov 2019 09:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4bPJbhfvKN1Ez54t8tVFmH1cs4sriWjqE1xwIaMz3/4=;
        b=qngK6aA1tzKGtJaiVGyj0/N2jgeCAnka86QBzC/9MzPxrVLjxqVWq+4B7A6luoAtDW
         iCEYhlLVzrQWMT8FV6LeINRdE2TacxONNCeCOutsI4Bt2CLa/WwX5xGz+sfdQCGIGXQ7
         O4hnJUqpYPznKByftfXmreM1jKlVVXr8BQMjxLg8YRBT2ddeJw/PPMdS3ZnSJNhOCo5/
         7kfYagDxshZVePwGNYma0XcsmR2/MDITl/LmD671X0BhYqVfXh2bjQ+K2CF6/GKkcmse
         5tK1J9aP6AbHWhIhQEIxZo+ooaj4A018e1pEf3oNrPvqPwOx1zD043NMK8LOntn6xuvq
         gZag==
X-Gm-Message-State: APjAAAUq0lSF1EgLpmLFCrOk3/kQnzNDbjUso9hNQJL877Cr9vH0wjRk
        2yfsQJ4lu2PPqKm4D7QpJw==
X-Google-Smtp-Source: APXvYqykovhU/onfqlNgUCJQUckAMq8E/joN14FDfrRFKJV1/fvETNj173u+QKDZp2z41G6xnSzTKg==
X-Received: by 2002:a9d:365:: with SMTP id 92mr357747otv.9.1574098783240;
        Mon, 18 Nov 2019 09:39:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l12sm6336032oth.76.2019.11.18.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 09:39:42 -0800 (PST)
Date:   Mon, 18 Nov 2019 11:39:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benoit Parrot <bparrot@ti.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Benoit Parrot <bparrot@ti.com>
Subject: Re: [RESEND Patch v3 01/20] dt-bindings: media: cal: update binding
 to use syscon
Message-ID: <20191118173942.GA6903@bogus>
References: <20191112145347.23519-1-bparrot@ti.com>
 <20191112145347.23519-2-bparrot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112145347.23519-2-bparrot@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 08:53:28 -0600, Benoit Parrot wrote:
> Update Device Tree bindings for the CAL driver to use syscon to access
> the phy config register instead of trying to map it directly.
> 
> Signed-off-by: Benoit Parrot <bparrot@ti.com>
> ---
>  Documentation/devicetree/bindings/media/ti-cal.txt | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
