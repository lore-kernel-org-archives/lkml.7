Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5516C31E44
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA861205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 22:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560290482;
	bh=Bt0HGRGv8d5bwQwnCiqo8yLA4cyS97HZ5bEY2lqzYXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ly8XaVn2f5EKIWVBL56hMXiDywWTKiQl/ymAokuLw9zMowchiZE6PKRLeAWlzmLi3
	 YeftHIAEZrFKR3SWKicSA26uIF06qlg91NZJVLmsY9gcUXLHKQETyRdbR2hF0TPPEm
	 BjyBckSStjNeKlwHGSCqdLLcHwVJ7Ucoxg0Etz3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436694AbfFKWBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 18:01:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42818 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407758AbfFKWBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 18:01:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so16463633qtk.9;
        Tue, 11 Jun 2019 15:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wVRjad9Fc8BILg/+DYBhqnoHZfByaIOMm77zfoBIfY0=;
        b=uZheCOttbqblvyIMZwReeWp+JKZkUKNnu2dE7PFC6Ayj4XeuMQmtYZ7WfswaYJbQcF
         vOGVbYTmuPxAMwyLC004S0bLmcYiboju7syJ7Mtk+B+50jjdMzQ+YrNHZh1SYSrxY+VL
         /gb2QmzjjonwcTtZyBQI1OseExiibPQbdd7ATSHuyf4ESdngBp/2CsZ8+5V5mfvir+8s
         LLf1GDzvcJYS9r6YT2OUn0qoIp/bJDutb8gsV10YK/nesxcS/Ri44EE3kKZV7VsPrXbr
         HkH1F+DJ/NG22BGf6czObAZ5M96xGGQzxOWUTwLi6vCiQkbsQIV7HNk9KwMFlwAXLq4x
         oAGQ==
X-Gm-Message-State: APjAAAUW+2mrC6Zwr9mHJnEewB70KZwGWWg6N/sVLhUr6jD2t/fwnqYF
        wKhc9t86sFPVMhWLqKvXig==
X-Google-Smtp-Source: APXvYqxq+ctalxr4J055wzK7JBghbqhScsopOPimJQptlh5w/Pu3JDApOeKWxso3z1UIm9uUmO+OTw==
X-Received: by 2002:ac8:c45:: with SMTP id l5mr50644561qti.63.1560290480260;
        Tue, 11 Jun 2019 15:01:20 -0700 (PDT)
Received: from localhost ([64.188.179.199])
        by smtp.gmail.com with ESMTPSA id g5sm8812899qta.77.2019.06.11.15.01.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 11 Jun 2019 15:01:19 -0700 (PDT)
Date:   Tue, 11 Jun 2019 16:01:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rocky Liao <rjliao@codeaurora.org>
Cc:     mark.rutland@arm.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        thierry.escande@linaro.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, c-hbandi@codeaurora.org
Subject: Re: [PATCH v6 2/2] dt-bindings: net: bluetooth: Add device property
 firmware-name for QCA6174
Message-ID: <20190611220117.GA31601@bogus>
References: <1557919203-11055-1-git-send-email-rjliao@codeaurora.org>
 <1559814055-13872-1-git-send-email-rjliao@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559814055-13872-1-git-send-email-rjliao@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 05:40:55PM +0800, Rocky Liao wrote:
> This patch adds an optional device property "firmware-name" to allow the
> driver to load customized nvm firmware file based on this property.
> 
> Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
> ---
> Changes in v6:
>   * Added read firmware-name property for both QCA6174 and WCN399X
> ---
>  Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
