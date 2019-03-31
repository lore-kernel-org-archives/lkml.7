Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87451C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ED520882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014447;
	bh=2SAUjQbpVOWY1VoWkBzeM9WdFRnNpKTxbQDlHdJbcJQ=;
	h=Date:From:Subject:References:In-Reply-To:Cc:Cc:To:List-ID:From;
	b=NTiemBar3MSenQKTy8AKXI+vWBBdiNGyI4OpLFfwDYdRKeLxozTpAVkNSuB09JWTK
	 PnnhPh8Nfu0W49wIoZeU+JWXqCf/ALz30c7lnZfSsUTk1PSPFwC7HuFIljez1r03Ph
	 mHVRP+jmTA3Ko/Q9kkf0gp7kbfxmr6ZXLMT5c9ys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfCaGkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:40:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33797 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfCaGko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:40:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so3173108pgq.1;
        Sat, 30 Mar 2019 23:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=xZTMUV5RCmijUMDZ0Ud0T7Ku5dtiOSk5cu61BHT3sas=;
        b=HH5Gd8Q+eC11mJAoStcmJd/nEGGynW8vg/vn0gGeklc8oGjU234kCykI0aeSbXEzgu
         F9JTml1mm4AmeHE6u6KNRr5didMdY6FORngbzoXCpbsAPmf+SpJw8gF6IRbNfux5UDR7
         N7D4JwpnKX3wQ4ZIFkUsjlapoc/k5GE0Qi56bv71p/JV8UAEHaXHkaFI7HVZbJNTUvJs
         xP8lD4lT+K/cbZaMBmwaH2mME4NFtfCm4yGng8jJiTFjwVK/5KNRQqbUh8Nicz1QcCEy
         8bTFYaErvPC1a/eSNCZuXZYxV1q/bTwf2uDPe3ApmRKn+pb8uufkF2HQmd5hNeHf0c0E
         VW2A==
X-Gm-Message-State: APjAAAUFoD3dKa9YuG0aYlliTrx5s3fBDR5klUtHfEsWZax+nhdjaXyU
        I2Ha/3gp51lxOawaZ/HeV/GC7AJBZA==
X-Google-Smtp-Source: APXvYqzvZF9IH+1Ea6A+T6u55/jLckxgGFhoKOAW2e/UXImIkYRkpmlP7injVXDXLqJZZFj35X+D6A==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr54266510pgd.194.1554014443052;
        Sat, 30 Mar 2019 23:40:43 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id e4sm5266886pgd.32.2019.03.30.23.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:40:42 -0700 (PDT)
Message-ID: <5ca060ea.1c69fb81.4ef19.df63@mx.google.com>
Date:   Sun, 31 Mar 2019 01:40:40 -0500
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: iio: add Bosch BMG160 gyroscope sensor
References: <cover.1552922054.git.hns@goldelico.com> <1664da2e7a9cb687eece1f27501d275219bcc4ed.1552922054.git.hns@goldelico.com>
In-Reply-To: <1664da2e7a9cb687eece1f27501d275219bcc4ed.1552922054.git.hns@goldelico.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2019 16:14:15 +0100, "H. Nikolaus Schaller" wrote:
> Define bindings for "bosch,bmg160" and "bosch,bmi055_gyro".
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  .../bindings/iio/gyroscope/bmg160.txt         | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/bmg160.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>

