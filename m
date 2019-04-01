Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AFEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB37521924
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138587;
	bh=AIVlAsgQvl3DEiAIpqFpJMh0lnYUqotxo3uvmpqVMLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BlolyCm0izjWb9c45PcVLoh/K9hXGbrZru1OXbqznglx6UwLmEhE0Tk4c0+yfzVo9
	 XpjwXbh5yPdWMr1J2hEat/WDqU7bfSS1SIpYcYH5Y1lB2VePQ8LIdAkxPY5O3SIVqn
	 1VrZ1JzwFtrxd/dDU1C+Sr4ZbDX5kR3FNLbv/Cp0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfDARJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbfDARJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:09:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FA7A21924;
        Mon,  1 Apr 2019 17:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138582;
        bh=AIVlAsgQvl3DEiAIpqFpJMh0lnYUqotxo3uvmpqVMLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gzc+RxAxMNps/slAhYs86U9M0/4o2TrYhekLllygJ2yZSYFIwAZl7nL2yYTpQIbxS
         +Nnge22vUWQbXI8fPyobn4mOFoNfKs625cMbFcVM4bott5lRdg/PUnPpe11TgpafwS
         DGrrU5Ss0D2LmTrzKcROaOCHm1skt0Kz4w00FTRE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 5.0 108/146] drm/i915: Mark AML 0x87CA as ULX
Date:   Mon,  1 Apr 2019 19:02:00 +0200
Message-Id: <20190401170057.705217358@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 4b9a3932e7ba929baa231231e61874c7a56f8959 upstream.

If I'm reading the spec right AML 0x87CA is a Y SKU, so it
should be marked as ULX in our old style terminology.

Cc: stable@vger.kernel.org
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: c0c46ca461f1 ("drm/i915/aml: Add new Amber Lake PCI ID")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190322204944.23613-1-ville.syrjala@linux.intel.com
Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
(cherry picked from commit 57b1c4460dc46a00f6ec439f3f11d670736b0209)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_drv.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -2293,7 +2293,8 @@ intel_info(const struct drm_i915_private
 				 INTEL_DEVID(dev_priv) == 0x5915 || \
 				 INTEL_DEVID(dev_priv) == 0x591E)
 #define IS_AML_ULX(dev_priv)	(INTEL_DEVID(dev_priv) == 0x591C || \
-				 INTEL_DEVID(dev_priv) == 0x87C0)
+				 INTEL_DEVID(dev_priv) == 0x87C0 || \
+				 INTEL_DEVID(dev_priv) == 0x87CA)
 #define IS_SKL_GT2(dev_priv)	(IS_SKYLAKE(dev_priv) && \
 				 (dev_priv)->info.gt == 2)
 #define IS_SKL_GT3(dev_priv)	(IS_SKYLAKE(dev_priv) && \


