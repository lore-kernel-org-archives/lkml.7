Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F3EC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0FC217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 13:31:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDKNbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:31:16 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:53857 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfDKNbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 09:31:15 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.50.113]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Md6ZB-1geh0C0aKR-00aGjG; Thu, 11 Apr 2019 15:30:35 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V5 2/3] Documentation: pwm-fan: Add description for RPM support
Date:   Thu, 11 Apr 2019 15:30:10 +0200
Message-Id: <1554989411-23666-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
References: <1554989411-23666-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:jyT+4bfq/XpXokbwRm/583mPpdzwznmhDqpzS778JiCUaGSgsET
 S41oxiO1ncHfXBsrZaGAVqM7v/qLYz/DgpDcZxUVVu6P9gJ5h2n2HkhUwEwDI80TbqGAL+X
 AxcneG57THUdJRLmoSbMvpaf2k/nAznesYY1HJrQW3D6WC+dZLjJ6zvaOqlstUsbV/YZyc5
 AueRrFqgFKS+VoWpXr/BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GTUCbIHG/iA=:hGkIMcFPpzt71wthA3hzmn
 TN/c2a1KLGPXvoP/3t2xQo96fI9jhbKE6I7fzW+u8HRS/6PviaMWxW74sJ5kLdb8SKX8/XBL0
 gewpbItNek58gsONg6hRaX6A4DZuP2Ypn5Ujn/6H+L3R+WxDbj2QVKAeH5axqr8ZXyVB+Xf1u
 U2kgCm7pjpppgwEYsIdYLHoY3pgqliSwlgQF7Mmuf/KHVw7iSR0evH7xytrEDjca7iaCirycb
 c8Fb7NP1GWIpIIxvyLrWOVTnq11v+ae+s9ts6A5c5G6AXbHx9zxPrRM2B5rvkZWGsa4MfFhqX
 LjdDKXEeXB5eXmbKvfsOXKkLv4pHJ4HKz5zjSg2DKa7AlHDQ1wXJl/J8m5+7iZDy3iw2vMb1r
 rnemmF41Eq0Vmy6/iX8vZoedwNyHvEG0UqNgWTZxTb8doxiSeF1igt7FgGLX0GZl4+NTMinqn
 umTD9P6/LqAMQQqfy4+m5VGgLpv6A4DdfjFg33BSBEiLdlhHXP+fkhptS1lIWW0fAG9GMbPfG
 HQKVZuslREWot2ZjgVwspBQ7XBT6iCENbc0+LWOdjsGC1oHDYs0ca+cpkY97q492bYsBoW39G
 klTnvtjFKTd9eA/V6rEV7PDkikPgVB4tV5Rk3OhqKCgHur17aD2WN1ISSlAndgKiMw58aMi1A
 c7lUDaylHOP/JZcAVLNQWR1XmzOqn2sxLjF7WZUlBJRnlS0LgqX+8bQNcOr9hFY0FbH9QnVZl
 TPbYeXsjDSkOKjqpn5WFqZlMUguVVVzO9qqyg7PcOjbvy+BEdyVL1hJX9jA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a short description for the new RPM support of the pwm-fan
driver.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/hwmon/pwm-fan | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/hwmon/pwm-fan b/Documentation/hwmon/pwm-fan
index 18529d2..82fe967 100644
--- a/Documentation/hwmon/pwm-fan
+++ b/Documentation/hwmon/pwm-fan
@@ -15,3 +15,6 @@ The driver implements a simple interface for driving a fan connected to
 a PWM output. It uses the generic PWM interface, thus it can be used with
 a range of SoCs. The driver exposes the fan to the user space through
 the hwmon's sysfs interface.
+
+The fan rotation speed returned via the optional 'fan1_input' is extrapolated
+from the sampled interrupts from the tachometer signal within 1 second.
-- 
2.7.4

