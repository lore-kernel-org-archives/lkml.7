Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC0BC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1AB2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 18:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gff7s060"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDLSOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 14:14:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39165 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfDLSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 14:14:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id z9so8159434lfh.6;
        Fri, 12 Apr 2019 11:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pf8HOcVDxGx+uRf35HlC+wiwfnwurmQHN03wRbrD37M=;
        b=gff7s060Zrc92xxYzWOQvoNIaT/t4kvnlUqoOUGRwS6hfK4MmQwq+gJ3epRqOGozIM
         9W5PyD2tCllXmXFld8j51Ptmy+z4jWPqqi+eSA4OGNdrJH+E3gFdYF1TyTHiqB4XMXRa
         fg11HHm26X3GqHIIL/k0ZZp04ZrTWIc1youioPBAyYKsKLMq4KOZSArvfrG6pPLrH+/0
         cbHQIr2GPc2emSa39sUDxsODZN+vNVmjbxEUz93QiDnJWGtD3zR+nLEip+5LJtl+dFj4
         cJrxS+vU1KPeQ7NgGS/16zFM1acCeCTHQyaZmj9+EnkvfK7FcVM+yu9SGijLuVr5APaN
         tWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pf8HOcVDxGx+uRf35HlC+wiwfnwurmQHN03wRbrD37M=;
        b=oWCC0rK6O0yqMl7STnscELcFM++j8JQzMz8qHBiucbOaoDe1woVVGP+sEwXi7Ieft4
         BSJo6UO0z4/iHGGIxWdO13l/4J1Yp6Qewxz/t6tbYQlhsgTjarzx4O2lWmR1olP/M+XS
         Muqe1Cxn+52pkpgGSKZS59+jDlI0Z3towVbKaHsPdHoB6yy8zwxNV3XA/ue+D8WiWSo2
         19/KG/a9WeeIDhIf2N53pjH9xVzvD25UlVYiCU4Ehw7g2w3L6RgxdUA9lSA2mGNMUsPF
         SUU8OqvlM5NcmBxJkxB8qKJwZ1IS537QdB1SYmsxKoiWvI12wGseh2BwXWfcAPHVb+fS
         BFoQ==
X-Gm-Message-State: APjAAAUlyQcp5NKaQKHxh7dcYPfDbCFrN/rp7sbyY5Efo/Yjz52S7Tf6
        5vx/yto9gddcK1sOKxO2JAod8dze
X-Google-Smtp-Source: APXvYqxESyMwd6yTnCiD8ouiwIzTG4pekpkNjOp8n25bW1ipaBAT683ypXPe8CRBct6xgXeb4DS5Sw==
X-Received: by 2002:ac2:490b:: with SMTP id n11mr1145325lfi.24.1555092885355;
        Fri, 12 Apr 2019 11:14:45 -0700 (PDT)
Received: from [192.168.1.19] (chg144.neoplus.adsl.tpnet.pl. [83.31.4.144])
        by smtp.gmail.com with ESMTPSA id n23sm1185417lfh.86.2019.04.12.11.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 11:14:44 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] dt: bindings: Add multicolor class dt bindings
 documention
To:     Marek Behun <marek.behun@nic.cz>, Dan Murphy <dmurphy@ti.com>
Cc:     robh+dt@kernel.org, pavel@ucw.cz, rdunlap@infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20190411193848.23140-1-dmurphy@ti.com>
 <20190411193848.23140-3-dmurphy@ti.com> <20190412000707.70f8319f@nic.cz>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <4e22f95f-8658-99cd-145e-b96f9e8314f7@gmail.com>
Date:   Fri, 12 Apr 2019 20:14:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412000707.70f8319f@nic.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 4/12/19 12:07 AM, Marek Behun wrote:
> Hi Dan,
> this probaly was discussed, but I did not follow brightness model
> discussions:
> what will happen if I set yellow by writing into yellow mode
> brightness, and then orange by writing orange model brightness?
> Will the resulting color be a mix of yellow and orange, or will the
> orange overwrite the yellow setting?

Orange will overwrite yellow settings. When color name is given
it should be treated as a hue. Then changing brightness level
should affect the lightness of a hue, similarly like changing
L component of HSL color model. This will be however entirely
up to DT brightness-model designer how they will design their models.
We are not going to verify that in the LED multi color class.

It implies that it will be possible to define arbitrary range
of color levels, not necessarily adhering to any established color
model. I think it could be useful to define brightness model
that allows to go from blue color (for cold) up to red (hot)
for representing a temperature for instance.

These ideas will need however more documentation. Generally
we aim to propose only a convention.

-- 
Best regards,
Jacek Anaszewski
