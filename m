Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97362C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBEA2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552415765;
	bh=3tAs8BS6SAK3HlWXbUsKByx9EV+tAy0fjRmYHRwtNZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DxftDZ+Y3ks2bTvzto17e3W8WDSHvWs6TIUhWegU348QMdhbCMG1zsdG9JXHotEP8
	 vuQIQL5M+ygOrawKFNb34eWyurljeeBgroLt7pVGjs3BGDoB1xQ9zIUokozXwik17M
	 iXw71362ykuk9AUqrXX6heI7FoPBV8wnhplnb2YY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfCLSgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:36:03 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46870 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbfCLSgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 14:36:03 -0400
Received: by mail-oi1-f196.google.com with SMTP id j10so2916936oij.13;
        Tue, 12 Mar 2019 11:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kPCtGJIPSajO7cpW3hg3I0j1qe6OnlLYLlcyK9Ff3HA=;
        b=fxfphI74MxE+dYljFbFHo73KpjybrhlNh9fI12PLrsUYqc02Ii2Ii44w9Zdt4HV9yt
         uia7R6hSlJnfay2hsouyfCQhDYlfel8ndywrWQ1Mj+agQUzhYCjHGGqURg4C+4SPuwX4
         vyGN7ahXBW5LzkgNoYaSC6Yi5x585lngAD8g9YCdYmfUfmNtRGRC80WsG6rNlbCdxXXk
         6i9dDPBd4QpmbRFiBh2lCXEtn0oYLXMdw5nelSrAvvuXcbZgnmAkiKXV/jpFoUIOqgpL
         zR9uS5MW8Vk5jvE1tRnvU2Psu9JxN68GWrVk7RW5mGUdQVIMoDTgRm32xF42ERZag4HM
         ooFQ==
X-Gm-Message-State: APjAAAXarrOH04vuzZyUvn98/BJv+2OSPuxZGi/uuYAJfaRGlKXUSQPz
        933ZOkmfmukI9nB5iuembA==
X-Google-Smtp-Source: APXvYqzCWUls0CfRJz9KMObFGGmFReVYLY3rfqf+6DEpYTi8C/9zO6obEAMUKBtnRcinqXHquKbJ4g==
X-Received: by 2002:aca:55cb:: with SMTP id j194mr2437911oib.39.1552415761963;
        Tue, 12 Mar 2019 11:36:01 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b2sm956271oih.1.2019.03.12.11.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 11:36:01 -0700 (PDT)
Date:   Tue, 12 Mar 2019 13:36:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Yang <decatf@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Yang <decatf@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: Add vendor prefix for Kionix, Inc.
Message-ID: <20190312183600.GA903@bogus>
References: <20190304151912.11485-1-decatf@gmail.com>
 <20190304151912.11485-2-decatf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304151912.11485-2-decatf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Mar 2019 10:19:10 -0500, Robert Yang wrote:
> Kionix manufactured MEMs sensors. There are Kionix acceleromoter sensor
> drivers which can be used with device tree.
> 
> Signed-off-by: Robert Yang <decatf@gmail.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
