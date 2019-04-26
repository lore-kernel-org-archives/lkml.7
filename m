Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BC8C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFBA2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556306571;
	bh=nlD1D4QGFj+6jowGj4uSL+44D+55t6PWw4urvseygko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xByonDMzlJPDTw54uB+8nmqxLMXlqhyg3ibVhCUOnwGsU8SYz6ZiCo2Mm75DYdS7v
	 eC/0HynZQjiVcpcw5W5bkAOUeiEJvHQN5AQK19NY723BWTg8dvzNa58ADqQlBarm/P
	 RCAQibH0lznR4P9Z7KrHhtdpfYMCOI0Hp6P9qF5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfDZTWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 15:22:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46304 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfDZTWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 15:22:49 -0400
Received: by mail-ot1-f68.google.com with SMTP id s24so3555710otk.13;
        Fri, 26 Apr 2019 12:22:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eObGxICpfVAjnrd7zCyTsZFj9+mp6QpitFjn2X8Bu8Q=;
        b=WN5mYysAXBX7UWhDdCXlu6C/qS0xPv9WSkGltQmw1YT0sIYiCkVdr1rxvibu5/syzO
         No9YifvldSipYg7Znk9KGgzRPbNFoJck8X3eYWH8pLErWXYTR2dWtUMArY8MqkW3goU0
         v3eJYrF3DTfQZoQuXmCKhx7PwuIJtgj8cMkWrW77BkbIyxVjPpxmLDmgs578YBUaZ50G
         IvZemCe/jFVUYlftp/ITb3+Y5/pEqc0Qvp8F2YJTckUlUI87/CCIwuThiwJQnJQ2+FKR
         u+Bay3XENqquS6UfNKMXYrP4Vdnr4NCNLfgd5/bSSRjBvnMON47CvJVNdAfwdakd6cNk
         yFZQ==
X-Gm-Message-State: APjAAAX+6ZDLBilT6wnj37ZVJ4zciRygZrNXmCufAqprtcVEbjxlfS3A
        qOy1NIxZw4pSA4tWWMIzPQ==
X-Google-Smtp-Source: APXvYqxlNTL6NcIK5OZJGItgau2FbRT2fkebxBE1FIDD45QgqzSorOz9vh5a4zxjm+aBaBSzbEgSlw==
X-Received: by 2002:a05:6830:9a:: with SMTP id a26mr3676802oto.317.1556306568973;
        Fri, 26 Apr 2019 12:22:48 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f5sm1173434otp.16.2019.04.26.12.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 12:22:48 -0700 (PDT)
Date:   Fri, 26 Apr 2019 14:22:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com
Subject: Re: [PATCH v4 19/26] dt-bindings: aat1290: Add function and color
 properties
Message-ID: <20190426192247.GA6807@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-20-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-20-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:32 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-aat1290.txt | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
