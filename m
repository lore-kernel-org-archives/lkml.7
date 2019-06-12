Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71194C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B50120874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 08:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436865AbfFLING (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 04:13:06 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47030 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436818AbfFLING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 04:13:06 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5C88tEa031260;
        Wed, 12 Jun 2019 03:10:35 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2t0ae2wjrf-1;
        Wed, 12 Jun 2019 03:10:35 -0500
Received: from EDIEX02.ad.cirrus.com (ediex02.ad.cirrus.com [198.61.84.81])
        by mail3.cirrus.com (Postfix) with ESMTP id C05F4611E3BA;
        Wed, 12 Jun 2019 03:11:19 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 12 Jun
 2019 09:10:34 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 12 Jun 2019 09:10:34 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3DE8444;
        Wed, 12 Jun 2019 09:10:34 +0100 (BST)
Date:   Wed, 12 Jun 2019 09:10:34 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: ASoC: Add TDA7802 amplifier
Message-ID: <20190612081034.GS28362@ediswmail.ad.cirrus.com>
References: <20190611174909.12162-1-thomas.preston@codethink.co.uk>
 <20190611174909.12162-2-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190611174909.12162-2-thomas.preston@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906120057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 06:49:06PM +0100, Thomas Preston wrote:
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Rob Duncan <rduncan@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  .../devicetree/bindings/sound/tda7802.txt          | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
> new file mode 100644
> index 000000000000..f80aaf4f1ba0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
> @@ -0,0 +1,26 @@
> +ST TDA7802 audio processor
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "st,tda7802"
> +- reg : the I2C address of the device
> +- enable-supply : a regulator spec for the PLLen pin
> +
> +Optional properties:
> +
> +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
> +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)

Does it make sense to have the gains in device tree? Are these
expected to be fixed by the system design, normally the gain
would be controlled through an ALSA control.

Thanks,
Charles
