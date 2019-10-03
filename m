Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027EFC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE75320830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ss2ZUDjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfJCR2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 13:28:51 -0400
Received: from mout.gmx.net ([212.227.17.21]:48675 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730170AbfJCR2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 13:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570123712;
        bh=GQhmM6Q8Z1o5q9YHR4jherpt7IjBuXvMOjoid+hpyz0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Ss2ZUDjLmYXfujIZAHNHXSnEnADyrhXH1A8zurENP8iS0hQDzNH4vtQNxgOUDWicn
         PPHPxdxGbwPrsreyYCMmOGvdpdQSO7UoWKAiBk9k/qW6Q1/gmJJPrPxI36P/mH0wIp
         Xi0sRqyvodWv2ex4mG9ANf738gGZz2J4vby8gBNc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([89.0.25.131]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQkK-1huInQ1N68-00vQpU; Thu, 03
 Oct 2019 19:28:32 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     intel-gfx@lists.freedesktop.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Add Sphinx-compatible references to struct fields
Date:   Thu,  3 Oct 2019 19:28:23 +0200
Message-Id: <20191003172823.8955-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uEoSon0QRk9LuiMg1o+ki0nsyjkCeAFzM81xtrmxJ8dlMknVTq0
 Y7bZxxpVEhVsRDG1BPwTD+x+JkptaSH1xtFfUymzW53FZtWhyXRyB94q0VqZXhE1ofO4nVU
 XvKsdg2Sao9ZlIgj5Ej8t+17h2Hlje/aQJZVtR0A6eS1r9QkCxthutGL7eSEgywv1C9me99
 io1GpODFaAVtlRD8x71zA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T9/OC7Ym66A=:NJ7P4FyBlwwnExsIKdfFOG
 rmD8UrUihtyOkpnEjFPD/7dhaFwACu4W3mL8Mu7xzW+mA4b/Z+y3JOf2wRNDJcdgj7RlAfmcW
 bTHovVmob3WcPdC0BNlp9hW9n8/5cXP5vOhu26MaWjA1DOz0NRoQtGLx+4lpCVsJg8hdv0Tln
 g8e3xztNkVRA74dnvFdYwycDkT+5INYJAE2ccoKs6qi1XkwPlACMdpAwb3D/1xR+DEH95uUJV
 RvAxbhXqC4VG+HhbLgbV4czSiqxIb2ZyJ7Qgs2caGWHSGrq/Sjjl8Y8VHpzve2snJxTWY1+xE
 AHVy8fGc9keOwr0qUtAgGdyiAPGF5FI++DyfgI1H2cJNE3ylV1YxH816+rcmaKzLEmy+XtT4d
 CSO4cfkMXBx4alz27KRmNMPkz6FyNN7u/XfOqoSS1Jf5Mp8goDdjVcdVqOrNasoKvf/dn7w5o
 6PXZWIQZK8+C0RehCiLDkyOyI71vhmtSNiy8m2uXpRDCShVUAJFSMkX2ShgQMcdIi4ENKu2My
 GFgQz16LvJUSzEMEV3eJX+m+SHmNHYlhsAbt8IO7VW0ik+HZlMYCTbanEj6qH9vIx5kCxtxhp
 Id334+tQKz8aP+qL5Mzb+OPXWKb+tBZtYZo/JY+AvGL7S/Cw7WFpbnZ8Vh8wZkSeqR6f0qpRF
 EeloIX6C6Pbfxa8+WlrFYHAy9W5+Gf+8aipGvnskz4strnsR4hqACcpC6TQBhaCKWeT2nzYWt
 fs1verZmRKu8OR3cpLnSyU0G1P44gM9FhBvbFoFRzvfFrzQwvH2zg0T7CvJlHCQbBFuv+sfcO
 aHL5tyBicAy+FiEJWJVAs8F9LNle0IWzWtNeAWgQe2Tf1lESTVX7iq1Ajhu7VkFBdx7weOhsU
 lhpc4eQhp7vRsnfnAP5tK6Wr/lVPiFCUpbW9TeWIBvKizce5+BUZmGnq06Kq0lUkQ9D1DCav3
 6XOGhG/fdJhpN9u4dW14GBlpr+oMyA8PDBolN/Q7LVkimla+bo/Q7lcYG4hYtmwt9p/CrLBTV
 FVRep2nXvXCYHu29JAcDWDMbZoYs18kCqMjUgQvXY9Gy2LwpgCNO4Q2/KsHOT9fzjKnRFxewe
 ykM7eypah980HnVRYNmYiFYmcSEWSc+uI9CSHxcLQG8kwOfnI0XnzwoyIUcijTKtVj2oleg3d
 BzEJFSavvANvBsTyT7FMANpTj+4iCcznjIuDpz42i7CouBKPL556eZlifWzNyqx1dP+DbMN5a
 sNb8oQDXSb+WB3kawU1oCMO/acQFCI9Oey6p/UXH67MIv36Lr2iq1/beI2og=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following kernel-doc warnings and makes the corrsponding fi=
elds
show up in the generated HTML:

./drivers/gpu/drm/i915/i915_drv.h:1143: warning: Incorrect use of kernel-d=
oc format:          * State of the OA buffer.
./drivers/gpu/drm/i915/i915_drv.h:1154: warning: Incorrect use of kernel-d=
oc format:                  * Locks reads and writes to all head/tail stat=
e
./drivers/gpu/drm/i915/i915_drv.h:1176: warning: Incorrect use of kernel-d=
oc format:                  * One 'aging' tail pointer and one 'aged' tail=
 pointer ready to
./drivers/gpu/drm/i915/i915_drv.h:1188: warning: Incorrect use of kernel-d=
oc format:                  * Index for the aged tail ready to read() data=
 up to.
./drivers/gpu/drm/i915/i915_drv.h:1193: warning: Incorrect use of kernel-d=
oc format:                  * A monotonic timestamp for when the current a=
ging tail pointer
./drivers/gpu/drm/i915/i915_drv.h:1199: warning: Incorrect use of kernel-d=
oc format:                  * Although we can always read back the head po=
inter register,

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 drivers/gpu/drm/i915/i915_drv.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_d=
rv.h
index 772154e4073e..55782e78f026 100644
=2D-- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -1140,7 +1140,7 @@ struct i915_perf_stream {
 	int period_exponent;

 	/**
-	 * State of the OA buffer.
+	 * @oa_buffer: State of the OA buffer.
 	 */
 	struct {
 		struct i915_vma *vma;
@@ -1151,6 +1151,7 @@ struct i915_perf_stream {
 		int size_exponent;

 		/**
+		 * @oa_buffer.ptr_lock:
 		 * Locks reads and writes to all head/tail state
 		 *
 		 * Consider: the head and tail pointer state needs to be read
@@ -1173,6 +1174,7 @@ struct i915_perf_stream {
 		spinlock_t ptr_lock;

 		/**
+		 * @oa_buffer.tails:
 		 * One 'aging' tail pointer and one 'aged' tail pointer ready to
 		 * used for reading.
 		 *
@@ -1185,17 +1187,20 @@ struct i915_perf_stream {
 		} tails[2];

 		/**
+		 * @oa_buffer.aged_tail_idx:
 		 * Index for the aged tail ready to read() data up to.
 		 */
 		unsigned int aged_tail_idx;

 		/**
+		 * @oa_buffer.aging_timestamp:
 		 * A monotonic timestamp for when the current aging tail pointer
 		 * was read; used to determine when it is old enough to trust.
 		 */
 		u64 aging_timestamp;

 		/**
+		 * @oa_buffer.head:
 		 * Although we can always read back the head pointer register,
 		 * we prefer to avoid trusting the HW state, just to avoid any
 		 * risk that some hardware condition could * somehow bump the
=2D-
2.20.1

