Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B92CC73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0420C2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562703280;
	bh=+QYyYibaaK8BUNrtQ8acC/lJ1bfOa9xU68zaySRfZm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XJYTW1tsrnuk3t+HuTRaOs6tZTlCz0vZSZIIGQJHk6FfGrOjz3OJV/ukTIACixRCg
	 vonAipyY6yNzmd/MlH1Zx30iJkc9QDfMFRxUpF7gtjx6Id/iCQWz7LkV4bGfQ4ZMTr
	 N6OU+hxe/9E8LqiCN/wkbGPCFDfBH5KE0JyE7Q5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbfGIUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:14:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35541 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfGIUOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:14:38 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so36470800ioo.2;
        Tue, 09 Jul 2019 13:14:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A1/xTjTSPh9Z7KyW2jKR4Hnz7NN0PO/syvRKDcdwkuo=;
        b=gJal/opK/gNzf7yN0v3VA4BpfuiRSPf+WCTjxzc/RvWJFGc2PpOaMmnc5O3DlTjs/F
         7L4OqnvXYJBZRAhapL5aZ1GttS52Vg5VKPpFgiL5Ven3aM03Fe97g3xyj1dC/vUuHoyx
         zBf/sQ9497aV033uspdBFZH+0dyvXBdTHeUwFY2Kq0vNkEoZdhTBbEHrCKKWSKO5sStz
         CSAu+kCttBcGx8sQcVAdr0kRPNHrI0OLX+cvfvuy8atMY9688jtQxcr0ng/9WTkvOB4l
         d8XHmI31Jv8cxwmByADC+TyAuR+bulEuSPCJydtzowN2jF4tQ1KE9opkn1NzAUnAwvm0
         uRqA==
X-Gm-Message-State: APjAAAWgxIaMtCD9pQqk0YCqKePnF2s65hYzlO6ACwW6IqODz0S5fgbW
        f3D4MdYnSr5nisTd33YXcg==
X-Google-Smtp-Source: APXvYqz890fMQxjAYEwyDmj2GDcTwYNN0cISWPzNtAE6+7uSZG4XOVnsCRmstiNAoGtWyLSjsizDWQ==
X-Received: by 2002:a5d:9c46:: with SMTP id 6mr2461744iof.6.1562703277337;
        Tue, 09 Jul 2019 13:14:37 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b3sm16959108iot.23.2019.07.09.13.14.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Jul 2019 13:14:36 -0700 (PDT)
Date:   Tue, 9 Jul 2019 14:14:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 5/6] dt-bindings: usb: bdc: Update compatible strings
Message-ID: <20190709201435.GA18881@bogus>
References: <1561064991-16874-1-git-send-email-alcooperx@gmail.com>
 <1561064991-16874-6-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561064991-16874-6-git-send-email-alcooperx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019 17:09:50 -0400, Al Cooper wrote:
> Remove "brcm,bdc-v0.16" because it was never used on any system.
> Add "brcm,bdc-udc-v3.1" which exists for any STB system with BDC.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/brcm,bdc.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
