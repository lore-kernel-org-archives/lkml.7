Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3270CC5DF61
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E71206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 22:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572994107;
	bh=e1zDeItANpkU5aMHH3CBq3r2RpezJeQI7Bnf2sQsRP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OoG8s5SkV//CKFcTo0xAOo8h9dGgvsM8bYfr8Hf7o9VvxEdfZux16pyH6geDk0iXO
	 TROwPECjGabj3DUkiBXVvgxivjsY5RpWjWYjrR+/5JYOtdfe2FR+SKzuJsTGjEm074
	 YA7DFegOJqKWyyM+2koiJz99EhHp4jEJfN035Giw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfKEWs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 17:48:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35930 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730192AbfKEWs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 17:48:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id j7so19197547oib.3;
        Tue, 05 Nov 2019 14:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a6RSlGUG/d/8KzpTd4sRswnPYzvmhaAeGKhO7ae8r/I=;
        b=JPA5QQNYfVJfc9zVzSLqM+xaphkQSbzOEcA/RYMwxFXRYXsbbCk5waOqQhkoKcbaUg
         6Ci45roKUFgGg7IjhbylXjasiu6c02whq2Bj+Ph7a+LzErYMcnHYXUhcMk6OuGnP3RuO
         9vC38WgNmgVar+y8gTMDWBmuD/rhQkyTS+fIXJS60GjGh7uwG5DZ6/Ioc6zQvxXvbIyA
         6NT7oVB8pcyZWQZLKj+CYSj99qNnf1pX2r/YiI6Xj6Qdc+5vn7fuTmuZfZZIiadrSUBY
         NEDqaMrNe4FkUvNEdso8dhQ4FTzCwLde7RM6ywSQzPcYuvs8KebT+Pmj2EWAav5l+Vss
         nH0Q==
X-Gm-Message-State: APjAAAU8ay2hvclbfV1IbE6n/WoEfvMNCadE8JRkRDNJnUFWS7i9DTYe
        2EoG1MUi6WC2aYy3C1TKEZIaxes=
X-Google-Smtp-Source: APXvYqzcMPSnJ3OYS20YBUOnhtN5LeFqqMXUqA8iDmlBcXVY/2pwmyIQcwIu/ev22CTSndlo/euKwQ==
X-Received: by 2002:aca:c489:: with SMTP id u131mr1274106oif.21.1572994105412;
        Tue, 05 Nov 2019 14:48:25 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n9sm6779413otn.4.2019.11.05.14.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 14:48:24 -0800 (PST)
Date:   Tue, 5 Nov 2019 16:48:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: serial: Convert Samsung UART bindings to
 json-schema
Message-ID: <20191105224824.GA8073@bogus>
References: <20191103160112.10764-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103160112.10764-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Nov 2019 17:01:12 +0100, Krzysztof Kozlowski wrote:
> Convert Samsung S3C/S5P/Exynos Serial/UART bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Simplify 'clock-names' patters after Rob's suggestions,
> 2. Add description to 'interrupts',
> 3. Remove 'uniqueItems' where not needed,
> 4. Remove aliases from example.
> ---
>  .../bindings/mfd/samsung,exynos5433-lpass.txt |   2 +-
>  .../bindings/serial/samsung_uart.txt          |  58 ---------
>  .../bindings/serial/samsung_uart.yaml         | 118 ++++++++++++++++++
>  3 files changed, 119 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/samsung_uart.yaml
> 

Applied, thanks.

Rob
