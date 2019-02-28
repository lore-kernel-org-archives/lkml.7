Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4669C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551380615;
	bh=DT8MgjK2AwyExQqXTigr8Ay3HLUAmKuvkwb61VwKDkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n2j7xFbggoQcpqxT8SSmYOmoeXNjUbS8pYms8MOSbRMWzI/D1neWcE7K58fWWxN72
	 IXWH3fsy2xtqh+y9/9zsSh2Bcs7PE6099M8nF/BI9oYETqmL+6VUdCiU9G2yqQmBAl
	 SfNrzzW3WYs0Rlthq1DuBse9ZCH1JL3W10akWCuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbfB1TDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:03:33 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44438 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbfB1TDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 14:03:33 -0500
Received: by mail-oi1-f193.google.com with SMTP id a81so17359637oii.11;
        Thu, 28 Feb 2019 11:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wMke4ZLhdK6k5PAV6wHM+Yxt9NPRu5NVUpmplRqfY+g=;
        b=Tn+4yyUsle2ze/TEeYj6b+ukwMriqZf1dVQTxnrDjSdu7qCpHdiTFjaWdSTpg/JkG7
         8eP6wMCrt90JoRQe1id9ERMUZjW0Atlbx6KsfjDhWS5jVBbpQjIVCLAmOSuPLV7jxoxh
         4Wj5ZzFYDzmer1iFe9jgKoYAiuxpl44mFphwgl/a2jTYyrczkYiEaNKhOe55ZcS6fetk
         679CAJthRCs3NreWbD5a5WqB0FWlutcgW4LpqY+uEuA+W9QSnnPiTx/wc2YzSaL25jMv
         yRYBPOCY9BEAcKHAHsUEdihlwAKNHEQoZ4LvWeRqmxUBi1dKLein0Ef5Zqt6b1RppEud
         GEBw==
X-Gm-Message-State: AHQUAua0TuwByvD1MJG94qqJNi2zCl1sQpa2Gk6I2nW6cvBXE9OzbqPb
        EuTUmGfDGz16BPvVS79mvQ==
X-Google-Smtp-Source: AHgI3Ib1Hg2fW9g2qhn7IVz4lYeGuLjjzUv9u0PyB1izVRW63o5WBQBDGUoWYTT6GDE0Vcahb0gp6g==
X-Received: by 2002:aca:b503:: with SMTP id e3mr764944oif.87.1551380612634;
        Thu, 28 Feb 2019 11:03:32 -0800 (PST)
Received: from localhost (ip-184-203-129-180.hstntx.spcsdns.net. [184.203.129.180])
        by smtp.gmail.com with ESMTPSA id g128sm8508008oia.32.2019.02.28.11.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:03:31 -0800 (PST)
Date:   Thu, 28 Feb 2019 13:03:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: Re: [PATCH 1/5] nvmem: sunxi-sid: fix wrong description in kernel doc
Message-ID: <20190228190330.GA11355@bogus>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
 <20190217162316.14111-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190217162316.14111-2-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Feb 2019 11:23:12 -0500, Yangtao Li wrote:
> qfprom->sunxi-sid
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
