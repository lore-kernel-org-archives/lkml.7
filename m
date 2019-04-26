Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665CDC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDAA208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 18:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556305115;
	bh=Jm0ZTZ18qwlJ99D3xfUPFt3fzXHby8kjZ0Cse4BwT8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nNKb6s1YW6lFp2/NI4+bx9SJOQeLr2hd4nmbX7widu4KEdpp8NHJgjc9QQQjAN0Vd
	 ymkr9KDuLwb38/81OyuNc74kLfnferXoj1mW5ivjBHLWy93MUCRREu4nGxEcEnRt9q
	 tj+7kW7KLvRQVmTWaj4RAvK5IOqMd/Y/ZVEPnQaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfDZS6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 14:58:34 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37236 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfDZS6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 14:58:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id k6so3774239oic.4;
        Fri, 26 Apr 2019 11:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xFyV4ZIhDXkvsRBvZ+Ybg/PWq2d17FWjn+lRrTZpDs=;
        b=QAYXGUaU6bFGc37uwXyw+G8OwU0lGH5pyazquD4LAaEEMSENWc6Tzx/W2KJj9Rxfrq
         8w05CNw/sYR++KRN7udrHnqvwGKyHd+HwMTX6e27YP9SF/6iTxrTs0Vx8lGXFLIpPmVE
         zswlIDuWleiRLUEQmVUf5BfyCmmcTr64nVN047Vq3jk8rF0LOThp8bQgR873vfR8wrew
         auPurz80eJoY9kEAoywsoltUst1c14YNK0UiniwX51YzTLbVwjBRhq9MHyv2/JlBM4g/
         ihlGrXUP+f3NZ1qJIad4SJVNHe9K1jmzGN59Y5seExfM4xK8V3ADBujWu0YWFRLrR0wm
         IQ4w==
X-Gm-Message-State: APjAAAWX0pmME80ltTY2Ndt3AyZVl+jz4qsNJbbtqMU1Sjuml1u46dgH
        NX/Kgk+/I/UATVKPqekgcA==
X-Google-Smtp-Source: APXvYqxNQUosGppOuMb5KY+t0nDJ7i4tSorJPxIQQmYs5p1bkSORSYOOxoxVaO+TInRBcD7Iv+p5gQ==
X-Received: by 2002:aca:80d:: with SMTP id 13mr8082438oii.75.1556305112925;
        Fri, 26 Apr 2019 11:58:32 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v123sm10976354oie.25.2019.04.26.11.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 11:58:32 -0700 (PDT)
Date:   Fri, 26 Apr 2019 13:58:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz, robh@kernel.org,
        dtor@google.com, linux@roeck-us.net, jacek.anaszewski@gmail.com,
        Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v4 07/26] dt-bindings: sc27xx-blt: Add function and color
 properties
Message-ID: <20190426185831.GA28923@bogus>
References: <20190417205439.17685-1-jacek.anaszewski@gmail.com>
 <20190417205439.17685-8-jacek.anaszewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417205439.17685-8-jacek.anaszewski@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019 22:54:20 +0200, Jacek Anaszewski wrote:
> Refer to new "function" and "color" properties and mark "label"
> as deprecated.
> 
> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/leds-sc27xx-bltc.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
