Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212EBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B09207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570195327;
	bh=F2tIA28VTDGvri6f1ZPM7JmZLcTHNVkUQCIlIWP0u/g=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=as+W2zLj02MT96bq71bXgAxMvwj8Doab7SOYLyg124hqgJTfRmFYVa7zvvUwF4BVZ
	 iMlfTpvMIQftZel5i4GFkzNIRmLUegioGfxSgzm0JtvBoSSA4FLMYJn2qAGZ6yBBo7
	 RYDeuV8jIO8vHM7luVCB4EwIj1uqsa5YuzmIX3YA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388469AbfJDNWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:22:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35268 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387952AbfJDNWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 09:22:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id w2so5760051qkf.2;
        Fri, 04 Oct 2019 06:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2aDuPf4twmkFwThLyS3bwl/5nIwsnEizIPXIjY2GE64=;
        b=qOhI2dYuhST513A4y1A6zOK9o4aI6hmEIapUoQnoLVNuXaKecV6HXjGLyCwHhoSZbr
         Od56wxmiLpWn+iLA20Nf9Db38VbTk0a86Sj4GHliiwzkGvj/HKHpUAb4bjLStTUXQ13D
         VyxiAZD7Wwe09KXBf+uiGW13ibK3/AqTfyhPSl3RLbpOid2Ezc4DiQ6VqYt2bv9BbB5Q
         DWL5IR6nzid/INY4jf51ArBt96EZ/W3YqVOsTTft8PQXV2/U5OVIXVRC9zNAPMHcwfSw
         UEY+g6MJpsdRivDQ5IH8ZJZe6JXyiadhDb0tVY6UB6xZARgldpAPTKcjbmZ+p8p0nxEd
         o96Q==
X-Gm-Message-State: APjAAAXuw7BqoYOZsJ4U/YNAjqVT64dlCzP93FWPwxw1wh2HVGa/N+c1
        Znofn4QQjeUdg9p5FYQvUw==
X-Google-Smtp-Source: APXvYqwnlbML1gfh5GPpneIuwvch6Tr7Ku6GEbcqU72MA1C7dx7CAiuumT2tZSN7Gwv1bzkHani8lg==
X-Received: by 2002:a05:620a:55c:: with SMTP id o28mr9200252qko.13.1570195324890;
        Fri, 04 Oct 2019 06:22:04 -0700 (PDT)
Received: from localhost ([132.205.229.215])
        by smtp.gmail.com with ESMTPSA id c12sm3106833qkc.81.2019.10.04.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:22:04 -0700 (PDT)
Date:   Fri, 4 Oct 2019 08:22:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.4
Message-ID: <20191004132203.GA29838@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull a few DT fixes for 5.4.

Rob

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.4

for you to fetch changes up to f437ade3296bacaddb6d7882ba0515940f01daf4:

  dt-bindings: phy: lantiq: Fix Property Name (2019-10-02 14:14:58 -0500)

----------------------------------------------------------------
DeviceTree fixes for v5.4:

Fix several 'dt_binding_check' build failures.

----------------------------------------------------------------
Maxime Ripard (5):
      dt-bindings: dsp: Fix fsl,dsp example
      dt-bindings: media: rc: Fix redundant string
      dt-bindings: iio: ad7192: Fix Regulator Properties
      dt-bindings: iio: ad7192: Fix DTC warning in the example
      dt-bindings: phy: lantiq: Fix Property Name

 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml                | 1 +
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml         | 7 +++----
 Documentation/devicetree/bindings/media/rc.yaml                   | 1 -
 Documentation/devicetree/bindings/phy/lantiq,vrx200-pcie-phy.yaml | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)
