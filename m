Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31860C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DF0320578
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556218065;
	bh=58VDPqtLdQZ88knjIGTrutzHEM4jKBnupXFLQDFhAyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZNDHPz/AN+hQEPV/yhE0oElf565xaNoBmqFVLNwEH47z+UIIv6f6UzYvuJvjkMALt
	 w3L8r9sOqnvB71hA7mxcHHt1CdHIstw5hYaFYyPRB1Umf7634w2FdwaCK67yWT9DlS
	 WzGQWpwf4dTi/QxvXzpJXFz2mTIEfJW8Um72fMps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfDYSrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:47:43 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:43101 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDYSrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:47:43 -0400
Received: by mail-oi1-f195.google.com with SMTP id t81so880720oig.10;
        Thu, 25 Apr 2019 11:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=yXiFss0vsoyhJ0q1L+jTx3RrnB1EEkBfYKFClH1MxPE=;
        b=iPjdJUb1BFTGJTOXuZVKfaJCTuL6PTyMZ0bSPnGpSZ/p4a9im0GDt3JfOxZ0pnhFVt
         pqShpkMXa7a/Xy01RpctdSJKdZ1XeBYkyeIsQ9DTa5cHMswg9oo9X5iY/uHstY4srQQl
         8QDzf2D16grnkaVp2cAAgVgi14zsHgkCPrzxq/oTE1hM7a187dC6R21Q3rt5yiEp91Aj
         5QTJktig0tpAUQPzoc+colPsNRQ/dh/+EUh3QdlA7sV70+vwADWLb2SLksaOZtZQpcbq
         fitnFsZtoZaZam7xJmaPzfIW2tA/ttdpAXfC+QTp979fJnepMrRIVClkFWtXNkiS3jKZ
         odYA==
X-Gm-Message-State: APjAAAUDxK2qwtlqt8Bqzds6PxcsWksZgKrNZKXBA03oR00jsdtSnh48
        DIbSTObVbxTsmKe757gQ8Q==
X-Google-Smtp-Source: APXvYqxkivPCtuDEZfWO8WhLbScu0RlgUuZ/RnZfhK9LtSzktVkLz89O1tuw9sorDwS+Jxxb/0Ikpg==
X-Received: by 2002:aca:a88c:: with SMTP id r134mr4347008oie.139.1556218061963;
        Thu, 25 Apr 2019 11:47:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v123sm9707742oie.25.2019.04.25.11.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 11:47:41 -0700 (PDT)
Date:   Thu, 25 Apr 2019 13:47:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Harish Bandi <c-hbandi@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, anubhavg@codeaurora.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 2/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip WCN3998
Message-ID: <20190425184740.GA23300@bogus>
References: <1556194416-30842-1-git-send-email-c-hbandi@codeaurora.org>
 <1556194416-30842-3-git-send-email-c-hbandi@codeaurora.org>
 <B3F78119-055C-41EB-BE3B-C5C94825B93E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B3F78119-055C-41EB-BE3B-C5C94825B93E@holtmann.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 02:43:56PM +0200, Marcel Holtmann wrote:
> Hi Harish,
> 
> > Add compatible string for the Qualcomm WCN3998 Bluetooth controller
> > 
> > Signed-off-by: Harish Bandi <c-hbandi@codeaurora.org>
> > ---
> > Changes in V6:
> > - Changed Commit text
> > ---
> > Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 5 +++--
> > 1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > index 824c0e2..7ef6118 100644
> > --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> > @@ -11,20 +11,21 @@ Required properties:
> >  - compatible: should contain one of the following:
> >    * "qcom,qca6174-bt"
> >    * "qcom,wcn3990-bt"
> > +   * "qcom,wcn3998-bt"
> > 
> > Optional properties for compatible string qcom,qca6174-bt:
> > 
> >  - enable-gpios: gpio specifier used to enable chip
> >  - clocks: clock provided to the controller (SUSCLK_32KHZ)
> > 
> > -Required properties for compatible string qcom,wcn3990-bt:
> > +Required properties for compatible string qcom,wcn399x-bt:
> > 
> >  - vddio-supply: VDD_IO supply regulator handle.
> >  - vddxo-supply: VDD_XO supply regulator handle.
> >  - vddrf-supply: VDD_RF supply regulator handle.
> >  - vddch0-supply: VDD_CH0 supply regulator handle.
> > 
> > -Optional properties for compatible string qcom,wcn3990-bt:
> > +Optional properties for compatible string qcom,wcn399x-bt:
> 
> wasn’t the conclusion to _not_ use x things in compatible strings? I would personally prefer you list these two compatible strings separately. However I let Rob comment and Ack this if this is fine for him.

It's fine for me as it isn't the actual string used.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
