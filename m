Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7486C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920E0218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391564AbfIIUef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:34:35 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:44185 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbfIIUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:34:35 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MtO06-1iPVTp25eQ-00uoyd; Mon, 09 Sep 2019 22:34:11 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jyri Sarha <jsarha@ti.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>,
        Emil Velikov <emil.velikov@collabora.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tilcdc: include linux/pinctrl/consumer.h again
Date:   Mon,  9 Sep 2019 22:33:57 +0200
Message-Id: <20190909203409.652308-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/QqqGQ82u5FnWbqdP+LbmWnNSFW6MUOsg6NDDvR5njC66ZcA0Je
 L7djSnqII3g8lTGDbl/GBpLAil9uf6kZVGkLQaA2W9PzuLBzJEzWfDplIgVm2DyIO55lP5G
 N1v+MoAA4QQoj7lQoIp2nvGAf4vgnF+K5TlgBHoJWygDbvoBkE+XZb0GSj5CuwK1LsJfhUp
 3xPnWIVWeU204B5Qa4L+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YzuEVwEdJVE=:YBZv/R62O3TVU0Kr2ntzvH
 aEnQmenQ7MOIYP63yGzO2mA8M+3cIGxzLDgs7uKP6Crsz3wUv04WUwgdRwUNPWCe6boDSXxc5
 gGTtdrweJQCgl5aTEywkkPWdJP3ZMMnuHY/ya60EnGIAUKohQ/baIN+CeL9gMkXf0EB7ksufZ
 3EqgH1Qyx7FQ13cWHNzBqk6ZF3tCkfzUIIMWqFPQopT/b6xGX7Owv0JHyaoxH1zK+33uQw9U/
 W967y4S1+AWmCaEyHgAsFu/E0P4U66L7Gv+d9S9tNejzz9m+W38otjSxBjxaQOHPOgzbniAjS
 HaKCNKyRtUxWLdsphRh23wn0ppnqpmS+JSH5pCltY20+OWbBGRUOcfciVhRxcqYLCLxQW8y8R
 Ye3ymhXW0nulkvizvinLgcgXyTsBuYJNKziXMce6Qnzjtbar2TaOre/Aq3XESXFEbaw3bxStz
 Lq+zQLlMKzfv1V4nw+4kVID77Bu0UIJ5wTra0UaIVVBcGuoBZxXUCjEXiBOSbsP0L8s65+eTN
 RutaFlyLHKc5BZJvexf0QAxAQTGzo8vNn8k3EyubuR8/hEStCEf6WR2/cesO6GBMo+jcyczLi
 JEdZp5FwSLTF+jDHh1CmXIoxEW+nVA32dkROzopTDuv6RZV12gRHNnHDFvWkpoQMQgn2AX7+R
 PkJtWI5Y6ywaQF9th6ufH3BJWkxtYQC72oqleEdluMXxQA7dZJTBTWuDI+gV3O+yePzuPhrF4
 YUagZp9JK/Vt2O90LAbN5j+zaYaFITkuuvkNhKjHVJXS+UZpzguYOJBIQg1XjUH7abnif/GIv
 Jmr285ZZHI0n3k0l9iZvpYbzkcJWq8I2TD3L9zXuhYGrawYk34=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was apparently dropped by accident in a recent
cleanup, causing a build failure in some configurations now:

drivers/gpu/drm/tilcdc/tilcdc_tfp410.c:296:12: error: implicit declaration of function 'devm_pinctrl_get_select_default' [-Werror,-Wimplicit-function-declaration]

Fixes: fcb57664172e ("drm/tilcdc: drop use of drmP.h")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
index 525dc1c0f1c1..9edcdd7f2b96 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
@@ -8,6 +8,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_encoder.h>
-- 
2.20.0

