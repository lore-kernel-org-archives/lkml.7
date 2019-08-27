Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B51C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50AAC217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 15:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566919749;
	bh=fEkyehL9ZESVJNT5LOCpwCBXIv7jVmWzKLeGOhN1X90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ep2gkAf2z2tyE49vqD9sbIpzumonu7+YnLEe+Ut7zu4wUxQ8/wRgp06lJAWxuovKV
	 aRUpXnRLUkzbEUD5wAcvflUpKhzCWXl6ytfE1eDXy0eYbKw9WkEtW9wsx2xULvyH0/
	 pkeCldsuNvgnirKkAOYBzun+3FVxa4fHtuds4VnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbfH0P3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 11:29:08 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34306 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfH0P3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 11:29:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id c7so19089868otp.1;
        Tue, 27 Aug 2019 08:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J00Og4COUuio9dl8wM1PzByC3c7MGnLiX6uTGr+VxFk=;
        b=gh5Kcord4A3A7hzCx/3K8PGJ1A7l5DPLmC9g6EHuJoJB4Hc332BrWl0VWA6/Qe5wFK
         F1EbAVG8VDdclPwocZkC18ZUuptk69Gb4sScuZ98txOwShnt9U6p0SH1SHuleeOfS491
         s/Ww6wkGwYGytrmgYGZVgigcv5/yVCxx7v62MgSdEvosvTAUSFDdd22N0KQMdKNxkm9F
         Eavvi2xBOZg8hABh/SJd3zDR5KZgFKADUKT7+qOfdT5JrgCU2kz1RunHOsC2T5TJQJBv
         7l8V6tEvVVhCbhg84yObgS+9KtKxaWV2/u18lssyzz08fDtM1MoUo9VsGncCz/lk+/7w
         r4/g==
X-Gm-Message-State: APjAAAUecXiBhMK2ZvEVVGtAATFy6xXcpb8vFTtyt6qSyvrskqr1+FtS
        BuxCnFkho5WZuHcGQujg6Q==
X-Google-Smtp-Source: APXvYqxwKAHk9mNPIMzdVfKpVpTrDCMOQRLflS4nfZnip6LCEVNfcwi6o5BhJFMmIDQvrZlOVkvPHQ==
X-Received: by 2002:a9d:4004:: with SMTP id m4mr19130194ote.146.1566919747225;
        Tue, 27 Aug 2019 08:29:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm4750652otl.21.2019.08.27.08.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 08:29:06 -0700 (PDT)
Date:   Tue, 27 Aug 2019 10:29:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Wang <wangzqbj@inspur.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanzhijia01@inspur.com, linux@roeck-us.net
Subject: Re: [PATCH] dt-bindings: Add vendor prefix for Inspur Corporation
Message-ID: <20190827152905.GA29989@bogus>
References: <20190810095836.6573-1-wangzqbj@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810095836.6573-1-wangzqbj@inspur.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Aug 2019 17:58:36 +0800, John Wang wrote:
> Signed-off-by: John Wang <wangzqbj@inspur.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks.

Rob
