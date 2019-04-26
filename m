Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76655C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F7206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 21:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556315142;
	bh=XzXNABoAKNkpocBuqx1viF3gTN17qt4X8eq70Ew0xyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XvrRNBfrW3zNMC/qUQhy+TYkA+kv75Pjub8yZDMqpn4zXIYq3w8NXSLaISQ1ndF+k
	 U4hscN9//O1aMH9bWzmifoCZ35gYjifeD7tvSP3GNoYrQvRVBrm16VpCp/lNyCQ6H8
	 frRwLQcAih6f8myPUzIPneyt60BQLbbUecCrp5Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfDZVpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 17:45:41 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42031 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfDZVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 17:45:40 -0400
Received: by mail-ot1-f65.google.com with SMTP id f23so3886261otl.9;
        Fri, 26 Apr 2019 14:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uixqWZkXYqMmHxhf1bJFrlRr6J6RhaltFblgUArN8CY=;
        b=lujZGMKteL9hnsRn0CFzo+igshlvZCC9hTBD5wRNA9l1f1/47fPgn9YhwtvEJXZZuF
         6+kheYT7P/VKly1ZnWire9IuPpSFj+Ka/hcoS+s1ELlahYSJGFCvyqXof/hhoOhn3W9h
         ZWnfqTGhiE8ROUS9E4RW1a39qqAPXruJ4updcD0LWSx6iNql2LXzBAn4gTZ5Sovaos9y
         6fs+WfoJQpGRwy7qHO/7nrF/BGVKusuVWkkA8B88a4vMtjmkULGZRuhUPUoy9niqUxZi
         RwFdMKI9zEGgN96IvoVtZPv6PpL7akf+cAkiLeOtCeCEFQNBmG2h8pzDKTIv6vh8qBTC
         x8mQ==
X-Gm-Message-State: APjAAAWVqpjR4HsCXZP6uVrpv16SRtx8B1ByR3ur6VK+IA4eLQH/Ymtl
        qdU+DGSxLrh9PzEO3xNAXg==
X-Google-Smtp-Source: APXvYqyFL232FQopAeyXtwXlJdFgy4h/dz+IuPMIi6LrbiayrLXwjtQv+4qUbdp0zYZZMZTYu51jJg==
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr28619446oti.18.1556315139985;
        Fri, 26 Apr 2019 14:45:39 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i11sm10482364otl.27.2019.04.26.14.45.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 14:45:39 -0700 (PDT)
Date:   Fri, 26 Apr 2019 16:45:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     jbrunet@baylibre.com, narmstrong@baylibre.com,
        khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: clk: g12a-clkc: add Temperature
 Sensor clock ID
Message-ID: <20190426214538.GA29979@bogus>
References: <20190412100221.26740-1-glaroque@baylibre.com>
 <20190412100221.26740-2-glaroque@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412100221.26740-2-glaroque@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 12:02:20PM +0200, Guillaume La Roque wrote:
> Add clock id used by temperature sensor for G12A Socs
> 
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  include/dt-bindings/clock/g12a-clkc.h | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
