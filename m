Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B233FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8108D20850
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014667;
	bh=NC6j/qgQ9XcikVYvzZzPH1zcjP9b2Xj4b8lfWymsOJo=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=DoKD/mWIjizAxqUN+kCa4N+LkKzTSOBqrfaG4ao9GW+aYVuLtgdeRXDZXfikqdHMc
	 FoRWPImYSfDXhQogIRIjKmcw5hDwcO9yfKJ8ZQGUsOYJ4HQdzC7qsQkdm84SL5/umo
	 3CTKlU1JW9P8VjIgj6ioJ5oiD+7fJ74SxyG8wGVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbfCaGoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:44:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45282 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfCaGks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so2967754pfi.12;
        Sat, 30 Mar 2019 23:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=x2jpiFyGUJq6LVOJZy0rKzOLMszc5llnvmRLJkRVUTs=;
        b=F9F0j6XNJ1Rr+wBNYiO02a7h8cIK9zQMbjzxU9OEh1CZ57cSnu95q26Rbmx+3lBO/l
         KGQKbh9KYJF7QE9oaJDOg8u/A5lOphPWywOsrDm3YYUlXYrQcwWmkOledgvoATbvYWIx
         xy8Xph0nu5IcCC5HAhnRDxylIe+Ob+hUP+JE75fqyBUQmwI1g6DdlQlGZs8KUklvnHZG
         9IkuasjcdXcSuc9vPHwFdFMPVVHv77n8wFxx7Rt3BpsL6hcf9ZWR9u/FgjBtWD/WDnMw
         yY6BU0xPmiI1n24VoCQmWf3QCjB/JXyIVtEQeNjX+PYl56T6yciqn1tpSzxvcxP1xV+G
         aoIQ==
X-Gm-Message-State: APjAAAXzAWBV/FJWDEukmCFnN3ZgMI4vZHMtsFu5jWe2YDwbVZlEK+J4
        iTFu80s3nIgN7yK9p4+HbQ==
X-Google-Smtp-Source: APXvYqwAms/QBgPg9MeqoGR7IizZbeeogCpYE49gltAC5S+hUQGjXSMJuoJFUwiDhusHnO6an/g2ag==
X-Received: by 2002:a65:5249:: with SMTP id q9mr34044597pgp.104.1554014447906;
        Sat, 30 Mar 2019 23:40:47 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id d129sm4049531pfa.142.2019.03.30.23.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:47 -0700 (PDT)
Message-ID: <5ca060ef.1c69fb81.60281.9a9f@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:45 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: hisilicon: Update compatible documentation
References: <1552937931-23050-1-git-send-email-peter.griffin@linaro.org> <1552937931-23050-3-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1552937931-23050-3-git-send-email-peter.griffin@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de, xuwei5@hisilicon.com,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     john.stultz@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        yuq825@gmail.com
To:     Peter Griffin <peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 19:38:47 +0000, Peter Griffin wrote:
> The reset driver now supports the ao reset controller, so update the
> documentation to match.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

