Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35382C4CEC8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01657206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 22:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568412102;
	bh=fUTEfA0XCPIjUoxGbNxcsNTgP5CrQTXhEMZCCQ4JXhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvweTt0V01gh9afqNmvYPfTvtDhGMl82eglZYhoKr2COVkg5L1Z7A46W1kJ834GNe
	 yZSkPXtbh/3MMOT7JVSmsWPqIDoNSPcSkYrVmYyq+37KT++kvKsfMhqtzBd7H4qx/0
	 HZNp9YpTGIRgMiH/ZtXOJjp8Lj1WTQvthFumKFHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403958AbfIMWBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 18:01:41 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43726 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389815AbfIMWBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 18:01:41 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so3884624oih.10;
        Fri, 13 Sep 2019 15:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NhX4q4VvHbxL/YFwtYgsj7GHy+7WGzMk/sM+hDn3XjY=;
        b=e0MMXgN3HjOjicjL8rm5PX7wMyau6lGtrmqX+QRoBElImog6eDpDaKlWKl1+R/Ml50
         NjDqLoZvH/V7pvZJqEYOxIRx5Zr2/45gLsr2EzOANw6gcI8XUoDFEaq7VTUFHCaMNRXY
         HFYdI3USEak15CEIgDuCwezyLyG0mjZ6oovXFP+p4n1GiUZxx1bdhkwSYCZpPWW2MOjL
         5pdew7IqfF1rKW0T2hu4tncR0kbcKatObIGgyD4n9zYfKu+kaXEk0M7JTaLWUUNwxtiV
         LRW29mc5wJYwVWcAKI51qtBg15ZAZOw7QfvjPmN7Q0xTmii/2TmYSTDIZbGusnsK3oIv
         vzyg==
X-Gm-Message-State: APjAAAWOVl8jCzVRR3rfavegNf/gfbS24Xy4157TStngu8JtOeyQKuWy
        N2EKZSBmJUjqrcDQYrKuTQ==
X-Google-Smtp-Source: APXvYqyMN6cGhqQElJmPF0IJsDj8JgHPGW102AuveDAChh2mS8gBIHVvwPO4qeAYrkFmDMbX3MGMWg==
X-Received: by 2002:aca:3ed7:: with SMTP id l206mr5582343oia.25.1568412100159;
        Fri, 13 Sep 2019 15:01:40 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n23sm620772oie.24.2019.09.13.15.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 15:01:39 -0700 (PDT)
Date:   Fri, 13 Sep 2019 17:01:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: qcom: fix spelling mistake "ambigous" -> "ambiguous"
Message-ID: <20190913220138.GA17592@bogus>
References: <20190911153947.10203-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911153947.10203-1-colin.king@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Sep 2019 16:39:47 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake on the documentation. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/devicetree/bindings/bus/qcom,ebi2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
