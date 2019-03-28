Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6110D20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553797951;
	bh=T6Dxhz6PFyzOW+dNF7pOWBlC/aqoADmqQ0v05V9ank4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uQQ81WGZJdde2K63zQOb9ijdJEapIvYQfv+jv9TfRQ2caAaS+7BLxkIh+SPnUUq8I
	 NpjiPEnHPxaF3AoY2Kk0MU+WiKm8qhGPGPI+jBYQpppXNmvOcDZLEctziK/ps+zc5q
	 9IkJGc6+JvpFiahbb5meVPM+MuFw5SUpkEvdqNiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfC1Sca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 14:32:30 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45597 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfC1Sc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 14:32:29 -0400
Received: by mail-ot1-f43.google.com with SMTP id e5so19255718otk.12;
        Thu, 28 Mar 2019 11:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4a6h2FC/LPuqAXsg9VEzSXR5Wr/K7lH2YlWK0JuFis=;
        b=ZmZaUJQts+zP1K/NrfhHun+tYFHmP15YNJBqIMr77/bb8F0sw27z4XtEIQPVFQzOgb
         MVcxQPuGeTWDGEiFw278aoQ/OOd23AlRlSCOxLfJ3ndnozEsAD5jNeo7USsIwfytfYmG
         q5xnQXLEQdxDn0KqkV+t0XEbtS2M1Jz/e/rudKpmTglg1TzPLuZTogYgYTMo5lbr73TQ
         WDtWN9WkOt3qyZDxuBq0/+q4qRG9dDxz5VRcPtpyT5KOL3RIV6MH5QIzNDwQRDwgSCCr
         mEypSNZqa6hm8M13p5kWYguEhniI32C1shtLQS0f0kXAqZzQxAqop8Q175gMEh1niT+K
         Ix0A==
X-Gm-Message-State: APjAAAVACiocS5arsykNwzIGMrNmRTcPiC5MVgngdjq3mj/cb0MsslnR
        DC5SpjvIF7Xl6NWDE29U1GhB4IR9lA==
X-Google-Smtp-Source: APXvYqz3OmjAlnJkSIlR4rjcygE96DnZyQGmwLRnv3PQT745V3wfr4sdOA/kRv0536Ye326FisLmSg==
X-Received: by 2002:a9d:6c0f:: with SMTP id f15mr18505089otq.163.1553797948864;
        Thu, 28 Mar 2019 11:32:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 96sm7804745otf.17.2019.03.28.11.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 11:32:28 -0700 (PDT)
Date:   Thu, 28 Mar 2019 13:32:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     thor.thayer@linux.intel.com
Cc:     bp@alien8.de, dinguyen@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mchehab@kernel.org, james.morse@arm.com,
        thor.thayer@linux.intel.com, devicetree@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 2/3] Documentation: dt: edac: Add Stratix10 Peripheral
 bindings
Message-ID: <20190328183227.GA8948@bogus>
References: <1553529476-26181-1-git-send-email-thor.thayer@linux.intel.com>
 <1553529476-26181-3-git-send-email-thor.thayer@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553529476-26181-3-git-send-email-thor.thayer@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 10:57:55 -0500, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> Add peripheral bindings for Stratix10 EDAC to capture
> the differences between the ARM64 and ARM32 architecture.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2-3 No change
> ---
>  .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 106 +++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
