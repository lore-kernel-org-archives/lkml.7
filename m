Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE0BC3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9429620863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 13:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgABN0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 08:26:49 -0500
Received: from alexa-out-blr-01.qualcomm.com ([103.229.18.197]:49300 "EHLO
        alexa-out-blr-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbgABN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 08:26:48 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-01.qualcomm.com with ESMTP/TLS/AES256-SHA; 02 Jan 2020 18:55:47 +0530
Received: from dikshita-linux.qualcomm.com ([10.204.65.237])
  by ironmsg01-blr.qualcomm.com with ESMTP; 02 Jan 2020 18:55:34 +0530
Received: by dikshita-linux.qualcomm.com (Postfix, from userid 347544)
        id 3FC0C34E1; Thu,  2 Jan 2020 18:55:33 +0530 (IST)
From:   Dikshita Agarwal <dikshita@codeaurora.org>
To:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vgarodia@codeaurora.org,
        Dikshita Agarwal <dikshita@codeaurora.org>
Subject: [PATCH V3 0/4] Enable video on sc7180
Date:   Thu,  2 Jan 2020 18:54:57 +0530
Message-Id: <1577971501-3732-1-git-send-email-dikshita@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Changes since v2:

  - added changes to enable ICB in DT.

  - addressed DT schema and resource struct review comments.

  - added Venus firmware subnode for non-TZ platform.


v2 can be found at [1].
These changes depend on patch series [2] - [6].

Thanks,
Dikshita

[1] https://lkml.org/lkml/2019/12/20/126
[2] https://patchwork.kernel.org/project/linux-media/list/?series=219021
[3] https://patchwork.kernel.org/project/linux-media/list/?series=214797
[4] https://lkml.org/lkml/2019/12/27/73
[5] https://lore.kernel.org/patchwork/project/lkml/list/?series=418681 
[6] https://lore.kernel.org/patchwork/project/lkml/list/?series=424054

Dikshita Agarwal (4):
  arm64: dts: sc7180: Add Venus video codec DT node
  dt-bindings: media: venus: Add sc7180 DT schema
  venus: core: add sc7180 DT compatible and resource struct
  arm64: dts: sc7180: Add Venus firmware subnode

 .../bindings/media/qcom,venus-sc7180.yaml          | 136 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-idp.dts            |   6 +
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |  36 ++++++
 drivers/media/platform/qcom/venus/core.c           |  45 +++++++
 4 files changed, 223 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/qcom,venus-sc7180.yaml

-- 
1.9.1

