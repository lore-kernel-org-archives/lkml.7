Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D187AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9067B20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 10:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCGKeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:34:04 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:35813 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfCGKeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 05:34:03 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mi27T-1gXAER1kK9-00e4Rn; Thu, 07 Mar 2019 11:33:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Lindgren <tony@atomide.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: omap: avoid clang warning
Date:   Thu,  7 Mar 2019 11:33:32 +0100
Message-Id: <20190307103348.1591457-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:M8SIw3oqqCjCcd61eun8N19OfeWZQiz5N8FX/b6EzvEWStANqah
 EZfnRPGnJKowyQTAsIwyWzVHQOYwE4RLUpiAzOl+y+gXcoeLbhhvcctvjT01f6NCKdwUwdW
 YMwaSovGno0Im27aEMyHd8JML5K6SckioyuG2xFEbfBSPv6+y1tnPrtDjJrrffnTznj+NCI
 /dhI8CMJVw/InDaRfSyLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HOsUvpKv+2w=:1C2Nlm5Ra5iWyzHz0bOLvG
 8RxRaLni1MXWDXISslBO8clK9B9KlkpUTOdykIgB92IuLPWKQiAtn7UT/2dmQ1dBlNxm1BtjW
 a3YmHNXirU2f1mzV+Ny63WOITJhb6xRsfeNYt5TyZjHbmUAjISqrXVkwVSXDwRNfqcov/6MKc
 Ecd/CDSgpd+aIW4kBff/YITirJyT+B+NLqy+KhPccJD31O9ppD5fWdlSYlEQ+DL/1SfRgruxW
 W7eH+fGX52d1k10+pU3YlXyJHfvhESrVvPmFoG/l4YqULhEOestw1UkEwOSj6D4ow9BTVURF9
 FZFd7tZQ8nrvjOYHWcFTjHBa8byZB+QhY/QZRT5D+hJBHSF5e/i6AU2xdpEqdqfamfJ/Cz1YO
 MihM+ZstglUx5+FpHXXHoTjRov1Kwmseygh7RnkrTwDvDaz5lhed09v3Zo9AdKsVL5a16CSzd
 0yqIGDJcEge+cI4NlJiKxiRV39GzPDGWRB+8uxMSCE1Ka59y5Rnc7LzXHOCc4paPweCksJ/JA
 T5Hv7a2GNTXY1iI+5dOOBVvuXtL8FuHMvzZAkQ6sVghuB5N8Gr6fNPgv1n6s8IMU4KNQaowDQ
 da90906tc61O42kA2yiEBSntDCpCj41Kdmj1UGi3eYPbOvntR7gY81VPGtQZXNJIJG7QlZnkY
 PVPIdxbBQktVJxfY2ZpPId+4I66hDwU7Ek+44xhXc8IrooV8CUoU6diyYGMsj7lVrKbUjNlzR
 omtkncIeIXC5J35NS8xMRIidx46XEuVzkVmjeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang warns about a tentative array definition in the gpio-omap driver:

drivers/gpio/gpio-omap.c:1282:34: error: tentative array definition assumed to have one element [-Werror]
static const struct of_device_id omap_gpio_match[];

It's best to just reorder the entire file to avoid forward declarations,
which lets us use the regular declaration. To do this, the unnecessary
CONFIG_OF check must also be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/gpio-omap.c | 549 +++++++++++++++++++--------------------
 1 file changed, 267 insertions(+), 282 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index f4e9921fa966..9d743563f4c1 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1249,196 +1249,63 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
 	return ret;
 }
 
-static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context);
-static void omap_gpio_unidle(struct gpio_bank *bank);
-
-static int gpio_omap_cpu_notifier(struct notifier_block *nb,
-				  unsigned long cmd, void *v)
+static void omap_gpio_init_context(struct gpio_bank *p)
 {
-	struct gpio_bank *bank;
-	unsigned long flags;
+	struct omap_gpio_reg_offs *regs = p->regs;
+	void __iomem *base = p->base;
 
-	bank = container_of(nb, struct gpio_bank, nb);
+	p->context.ctrl		= readl_relaxed(base + regs->ctrl);
+	p->context.oe		= readl_relaxed(base + regs->direction);
+	p->context.wake_en	= readl_relaxed(base + regs->wkup_en);
+	p->context.leveldetect0	= readl_relaxed(base + regs->leveldetect0);
+	p->context.leveldetect1	= readl_relaxed(base + regs->leveldetect1);
+	p->context.risingdetect	= readl_relaxed(base + regs->risingdetect);
+	p->context.fallingdetect = readl_relaxed(base + regs->fallingdetect);
+	p->context.irqenable1	= readl_relaxed(base + regs->irqenable);
+	p->context.irqenable2	= readl_relaxed(base + regs->irqenable2);
 
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	switch (cmd) {
-	case CPU_CLUSTER_PM_ENTER:
-		if (bank->is_suspended)
-			break;
-		omap_gpio_idle(bank, true);
-		break;
-	case CPU_CLUSTER_PM_ENTER_FAILED:
-	case CPU_CLUSTER_PM_EXIT:
-		if (bank->is_suspended)
-			break;
-		omap_gpio_unidle(bank);
-		break;
-	}
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
+	if (regs->set_dataout && p->regs->clr_dataout)
+		p->context.dataout = readl_relaxed(base + regs->set_dataout);
+	else
+		p->context.dataout = readl_relaxed(base + regs->dataout);
 
-	return NOTIFY_OK;
+	p->context_valid = true;
 }
 
-static const struct of_device_id omap_gpio_match[];
-
-static int omap_gpio_probe(struct platform_device *pdev)
+static void omap_gpio_restore_context(struct gpio_bank *bank)
 {
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
-	const struct of_device_id *match;
-	const struct omap_gpio_platform_data *pdata;
-	struct resource *res;
-	struct gpio_bank *bank;
-	struct irq_chip *irqc;
-	int ret;
-
-	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
-
-	pdata = match ? match->data : dev_get_platdata(dev);
-	if (!pdata)
-		return -EINVAL;
-
-	bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
-	if (!bank)
-		return -ENOMEM;
-
-	irqc = devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
-	if (!irqc)
-		return -ENOMEM;
-
-	irqc->irq_startup = omap_gpio_irq_startup,
-	irqc->irq_shutdown = omap_gpio_irq_shutdown,
-	irqc->irq_ack = omap_gpio_ack_irq,
-	irqc->irq_mask = omap_gpio_mask_irq,
-	irqc->irq_unmask = omap_gpio_unmask_irq,
-	irqc->irq_set_type = omap_gpio_irq_type,
-	irqc->irq_set_wake = omap_gpio_wake_enable,
-	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
-	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
-	irqc->name = dev_name(&pdev->dev);
-	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
-	irqc->parent_device = dev;
-
-	bank->irq = platform_get_irq(pdev, 0);
-	if (bank->irq <= 0) {
-		if (!bank->irq)
-			bank->irq = -ENXIO;
-		if (bank->irq != -EPROBE_DEFER)
-			dev_err(dev,
-				"can't get irq resource ret=%d\n", bank->irq);
-		return bank->irq;
-	}
-
-	bank->chip.parent = dev;
-	bank->chip.owner = THIS_MODULE;
-	bank->dbck_flag = pdata->dbck_flag;
-	bank->quirks = pdata->quirks;
-	bank->stride = pdata->bank_stride;
-	bank->width = pdata->bank_width;
-	bank->is_mpuio = pdata->is_mpuio;
-	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
-	bank->regs = pdata->regs;
-#ifdef CONFIG_OF_GPIO
-	bank->chip.of_node = of_node_get(node);
-#endif
-
-	if (node) {
-		if (!of_property_read_bool(node, "ti,gpio-always-on"))
-			bank->loses_context = true;
-	} else {
-		bank->loses_context = pdata->loses_context;
-
-		if (bank->loses_context)
-			bank->get_context_loss_count =
-				pdata->get_context_loss_count;
-	}
-
-	if (bank->regs->set_dataout && bank->regs->clr_dataout) {
-		bank->set_dataout = omap_set_gpio_dataout_reg;
-		bank->set_dataout_multiple = omap_set_gpio_dataout_reg_multiple;
-	} else {
-		bank->set_dataout = omap_set_gpio_dataout_mask;
-		bank->set_dataout_multiple =
-				omap_set_gpio_dataout_mask_multiple;
-	}
-
-	if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
-		bank->funcs.idle_enable_level_quirk =
-			omap2_gpio_enable_level_quirk;
-		bank->funcs.idle_disable_level_quirk =
-			omap2_gpio_disable_level_quirk;
-	}
-
-	raw_spin_lock_init(&bank->lock);
-	raw_spin_lock_init(&bank->wa_lock);
-
-	/* Static mapping, never released */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	bank->base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(bank->base)) {
-		return PTR_ERR(bank->base);
-	}
-
-	if (bank->dbck_flag) {
-		bank->dbck = devm_clk_get(dev, "dbclk");
-		if (IS_ERR(bank->dbck)) {
-			dev_err(dev,
-				"Could not get gpio dbck. Disable debounce\n");
-			bank->dbck_flag = false;
-		} else {
-			clk_prepare(bank->dbck);
-		}
-	}
-
-	platform_set_drvdata(pdev, bank);
-
-	pm_runtime_enable(dev);
-	pm_runtime_get_sync(dev);
-
-	if (bank->is_mpuio)
-		omap_mpuio_init(bank);
-
-	omap_gpio_mod_init(bank);
-
-	ret = omap_gpio_chip_init(bank, irqc);
-	if (ret) {
-		pm_runtime_put_sync(dev);
-		pm_runtime_disable(dev);
-		if (bank->dbck_flag)
-			clk_unprepare(bank->dbck);
-		return ret;
-	}
-
-	omap_gpio_show_rev(bank);
+	writel_relaxed(bank->context.wake_en,
+				bank->base + bank->regs->wkup_en);
+	writel_relaxed(bank->context.ctrl, bank->base + bank->regs->ctrl);
+	writel_relaxed(bank->context.leveldetect0,
+				bank->base + bank->regs->leveldetect0);
+	writel_relaxed(bank->context.leveldetect1,
+				bank->base + bank->regs->leveldetect1);
+	writel_relaxed(bank->context.risingdetect,
+				bank->base + bank->regs->risingdetect);
+	writel_relaxed(bank->context.fallingdetect,
+				bank->base + bank->regs->fallingdetect);
+	if (bank->regs->set_dataout && bank->regs->clr_dataout)
+		writel_relaxed(bank->context.dataout,
+				bank->base + bank->regs->set_dataout);
+	else
+		writel_relaxed(bank->context.dataout,
+				bank->base + bank->regs->dataout);
+	writel_relaxed(bank->context.oe, bank->base + bank->regs->direction);
 
-	if (bank->funcs.idle_enable_level_quirk &&
-	    bank->funcs.idle_disable_level_quirk) {
-		bank->nb.notifier_call = gpio_omap_cpu_notifier;
-		cpu_pm_register_notifier(&bank->nb);
+	if (bank->dbck_enable_mask) {
+		writel_relaxed(bank->context.debounce, bank->base +
+					bank->regs->debounce);
+		writel_relaxed(bank->context.debounce_en,
+					bank->base + bank->regs->debounce_en);
 	}
 
-	pm_runtime_put(dev);
-
-	return 0;
-}
-
-static int omap_gpio_remove(struct platform_device *pdev)
-{
-	struct gpio_bank *bank = platform_get_drvdata(pdev);
-
-	if (bank->nb.notifier_call)
-		cpu_pm_unregister_notifier(&bank->nb);
-	list_del(&bank->node);
-	gpiochip_remove(&bank->chip);
-	pm_runtime_disable(&pdev->dev);
-	if (bank->dbck_flag)
-		clk_unprepare(bank->dbck);
-
-	return 0;
+	writel_relaxed(bank->context.irqenable1,
+				bank->base + bank->regs->irqenable);
+	writel_relaxed(bank->context.irqenable2,
+				bank->base + bank->regs->irqenable2);
 }
 
-static void omap_gpio_restore_context(struct gpio_bank *bank);
-
 static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 {
 	struct device *dev = bank->chip.parent;
@@ -1479,8 +1346,6 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 	omap_gpio_dbck_disable(bank);
 }
 
-static void omap_gpio_init_context(struct gpio_bank *p);
-
 static void omap_gpio_unidle(struct gpio_bank *bank)
 {
 	struct device *dev = bank->chip.parent;
@@ -1574,113 +1439,33 @@ static void omap_gpio_unidle(struct gpio_bank *bank)
 	bank->workaround_enabled = false;
 }
 
-static void omap_gpio_init_context(struct gpio_bank *p)
+static int gpio_omap_cpu_notifier(struct notifier_block *nb,
+				  unsigned long cmd, void *v)
 {
-	struct omap_gpio_reg_offs *regs = p->regs;
-	void __iomem *base = p->base;
+	struct gpio_bank *bank;
+	unsigned long flags;
 
-	p->context.ctrl		= readl_relaxed(base + regs->ctrl);
-	p->context.oe		= readl_relaxed(base + regs->direction);
-	p->context.wake_en	= readl_relaxed(base + regs->wkup_en);
-	p->context.leveldetect0	= readl_relaxed(base + regs->leveldetect0);
-	p->context.leveldetect1	= readl_relaxed(base + regs->leveldetect1);
-	p->context.risingdetect	= readl_relaxed(base + regs->risingdetect);
-	p->context.fallingdetect = readl_relaxed(base + regs->fallingdetect);
-	p->context.irqenable1	= readl_relaxed(base + regs->irqenable);
-	p->context.irqenable2	= readl_relaxed(base + regs->irqenable2);
+	bank = container_of(nb, struct gpio_bank, nb);
 
-	if (regs->set_dataout && p->regs->clr_dataout)
-		p->context.dataout = readl_relaxed(base + regs->set_dataout);
-	else
-		p->context.dataout = readl_relaxed(base + regs->dataout);
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if (bank->is_suspended)
+			break;
+		omap_gpio_idle(bank, true);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if (bank->is_suspended)
+			break;
+		omap_gpio_unidle(bank);
+		break;
+	}
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
 
-	p->context_valid = true;
-}
-
-static void omap_gpio_restore_context(struct gpio_bank *bank)
-{
-	writel_relaxed(bank->context.wake_en,
-				bank->base + bank->regs->wkup_en);
-	writel_relaxed(bank->context.ctrl, bank->base + bank->regs->ctrl);
-	writel_relaxed(bank->context.leveldetect0,
-				bank->base + bank->regs->leveldetect0);
-	writel_relaxed(bank->context.leveldetect1,
-				bank->base + bank->regs->leveldetect1);
-	writel_relaxed(bank->context.risingdetect,
-				bank->base + bank->regs->risingdetect);
-	writel_relaxed(bank->context.fallingdetect,
-				bank->base + bank->regs->fallingdetect);
-	if (bank->regs->set_dataout && bank->regs->clr_dataout)
-		writel_relaxed(bank->context.dataout,
-				bank->base + bank->regs->set_dataout);
-	else
-		writel_relaxed(bank->context.dataout,
-				bank->base + bank->regs->dataout);
-	writel_relaxed(bank->context.oe, bank->base + bank->regs->direction);
-
-	if (bank->dbck_enable_mask) {
-		writel_relaxed(bank->context.debounce, bank->base +
-					bank->regs->debounce);
-		writel_relaxed(bank->context.debounce_en,
-					bank->base + bank->regs->debounce_en);
-	}
-
-	writel_relaxed(bank->context.irqenable1,
-				bank->base + bank->regs->irqenable);
-	writel_relaxed(bank->context.irqenable2,
-				bank->base + bank->regs->irqenable2);
-}
-
-static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
-{
-	struct gpio_bank *bank = dev_get_drvdata(dev);
-	unsigned long flags;
-	int error = 0;
-
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
-	if (bank->irq_usage) {
-		error = -EBUSY;
-		goto unlock;
-	}
-	omap_gpio_idle(bank, true);
-	bank->is_suspended = true;
-unlock:
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	return error;
-}
-
-static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
-{
-	struct gpio_bank *bank = dev_get_drvdata(dev);
-	unsigned long flags;
-	int error = 0;
-
-	raw_spin_lock_irqsave(&bank->lock, flags);
-	/* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
-	if (bank->irq_usage) {
-		error = -EBUSY;
-		goto unlock;
-	}
-	omap_gpio_unidle(bank);
-	bank->is_suspended = false;
-unlock:
-	raw_spin_unlock_irqrestore(&bank->lock, flags);
-
-	return error;
+	return NOTIFY_OK;
 }
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-static const struct dev_pm_ops gpio_pm_ops = {
-	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
-									NULL)
-};
-#else
-static const struct dev_pm_ops gpio_pm_ops;
-#endif	/* CONFIG_ARCH_OMAP2PLUS */
-
-#if defined(CONFIG_OF)
 static struct omap_gpio_reg_offs omap2_gpio_regs = {
 	.revision =		OMAP24XX_GPIO_REVISION,
 	.direction =		OMAP24XX_GPIO_OE,
@@ -1768,15 +1553,215 @@ static const struct of_device_id omap_gpio_match[] = {
 	{ },
 };
 MODULE_DEVICE_TABLE(of, omap_gpio_match);
+
+static int omap_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
+	const struct of_device_id *match;
+	const struct omap_gpio_platform_data *pdata;
+	struct resource *res;
+	struct gpio_bank *bank;
+	struct irq_chip *irqc;
+	int ret;
+
+	match = of_match_device(of_match_ptr(omap_gpio_match), dev);
+
+	pdata = match ? match->data : dev_get_platdata(dev);
+	if (!pdata)
+		return -EINVAL;
+
+	bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
+	if (!bank)
+		return -ENOMEM;
+
+	irqc = devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
+	if (!irqc)
+		return -ENOMEM;
+
+	irqc->irq_startup = omap_gpio_irq_startup,
+	irqc->irq_shutdown = omap_gpio_irq_shutdown,
+	irqc->irq_ack = omap_gpio_ack_irq,
+	irqc->irq_mask = omap_gpio_mask_irq,
+	irqc->irq_unmask = omap_gpio_unmask_irq,
+	irqc->irq_set_type = omap_gpio_irq_type,
+	irqc->irq_set_wake = omap_gpio_wake_enable,
+	irqc->irq_bus_lock = omap_gpio_irq_bus_lock,
+	irqc->irq_bus_sync_unlock = gpio_irq_bus_sync_unlock,
+	irqc->name = dev_name(&pdev->dev);
+	irqc->flags = IRQCHIP_MASK_ON_SUSPEND;
+	irqc->parent_device = dev;
+
+	bank->irq = platform_get_irq(pdev, 0);
+	if (bank->irq <= 0) {
+		if (!bank->irq)
+			bank->irq = -ENXIO;
+		if (bank->irq != -EPROBE_DEFER)
+			dev_err(dev,
+				"can't get irq resource ret=%d\n", bank->irq);
+		return bank->irq;
+	}
+
+	bank->chip.parent = dev;
+	bank->chip.owner = THIS_MODULE;
+	bank->dbck_flag = pdata->dbck_flag;
+	bank->quirks = pdata->quirks;
+	bank->stride = pdata->bank_stride;
+	bank->width = pdata->bank_width;
+	bank->is_mpuio = pdata->is_mpuio;
+	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
+	bank->regs = pdata->regs;
+#ifdef CONFIG_OF_GPIO
+	bank->chip.of_node = of_node_get(node);
 #endif
 
+	if (node) {
+		if (!of_property_read_bool(node, "ti,gpio-always-on"))
+			bank->loses_context = true;
+	} else {
+		bank->loses_context = pdata->loses_context;
+
+		if (bank->loses_context)
+			bank->get_context_loss_count =
+				pdata->get_context_loss_count;
+	}
+
+	if (bank->regs->set_dataout && bank->regs->clr_dataout) {
+		bank->set_dataout = omap_set_gpio_dataout_reg;
+		bank->set_dataout_multiple = omap_set_gpio_dataout_reg_multiple;
+	} else {
+		bank->set_dataout = omap_set_gpio_dataout_mask;
+		bank->set_dataout_multiple =
+				omap_set_gpio_dataout_mask_multiple;
+	}
+
+	if (bank->quirks & OMAP_GPIO_QUIRK_IDLE_REMOVE_TRIGGER) {
+		bank->funcs.idle_enable_level_quirk =
+			omap2_gpio_enable_level_quirk;
+		bank->funcs.idle_disable_level_quirk =
+			omap2_gpio_disable_level_quirk;
+	}
+
+	raw_spin_lock_init(&bank->lock);
+	raw_spin_lock_init(&bank->wa_lock);
+
+	/* Static mapping, never released */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	bank->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(bank->base)) {
+		return PTR_ERR(bank->base);
+	}
+
+	if (bank->dbck_flag) {
+		bank->dbck = devm_clk_get(dev, "dbclk");
+		if (IS_ERR(bank->dbck)) {
+			dev_err(dev,
+				"Could not get gpio dbck. Disable debounce\n");
+			bank->dbck_flag = false;
+		} else {
+			clk_prepare(bank->dbck);
+		}
+	}
+
+	platform_set_drvdata(pdev, bank);
+
+	pm_runtime_enable(dev);
+	pm_runtime_get_sync(dev);
+
+	if (bank->is_mpuio)
+		omap_mpuio_init(bank);
+
+	omap_gpio_mod_init(bank);
+
+	ret = omap_gpio_chip_init(bank, irqc);
+	if (ret) {
+		pm_runtime_put_sync(dev);
+		pm_runtime_disable(dev);
+		if (bank->dbck_flag)
+			clk_unprepare(bank->dbck);
+		return ret;
+	}
+
+	omap_gpio_show_rev(bank);
+
+	if (bank->funcs.idle_enable_level_quirk &&
+	    bank->funcs.idle_disable_level_quirk) {
+		bank->nb.notifier_call = gpio_omap_cpu_notifier;
+		cpu_pm_register_notifier(&bank->nb);
+	}
+
+	pm_runtime_put(dev);
+
+	return 0;
+}
+
+static int omap_gpio_remove(struct platform_device *pdev)
+{
+	struct gpio_bank *bank = platform_get_drvdata(pdev);
+
+	if (bank->nb.notifier_call)
+		cpu_pm_unregister_notifier(&bank->nb);
+	list_del(&bank->node);
+	gpiochip_remove(&bank->chip);
+	pm_runtime_disable(&pdev->dev);
+	if (bank->dbck_flag)
+		clk_unprepare(bank->dbck);
+
+	return 0;
+}
+
+static int __maybe_unused omap_gpio_runtime_suspend(struct device *dev)
+{
+	struct gpio_bank *bank = dev_get_drvdata(dev);
+	unsigned long flags;
+	int error = 0;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	/* Must be idled only by CPU_CLUSTER_PM_ENTER? */
+	if (bank->irq_usage) {
+		error = -EBUSY;
+		goto unlock;
+	}
+	omap_gpio_idle(bank, true);
+	bank->is_suspended = true;
+unlock:
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	return error;
+}
+
+static int __maybe_unused omap_gpio_runtime_resume(struct device *dev)
+{
+	struct gpio_bank *bank = dev_get_drvdata(dev);
+	unsigned long flags;
+	int error = 0;
+
+	raw_spin_lock_irqsave(&bank->lock, flags);
+	/* Must be unidled only by CPU_CLUSTER_PM_ENTER? */
+	if (bank->irq_usage) {
+		error = -EBUSY;
+		goto unlock;
+	}
+	omap_gpio_unidle(bank);
+	bank->is_suspended = false;
+unlock:
+	raw_spin_unlock_irqrestore(&bank->lock, flags);
+
+	return error;
+}
+
+static const struct dev_pm_ops gpio_pm_ops = {
+	SET_RUNTIME_PM_OPS(omap_gpio_runtime_suspend, omap_gpio_runtime_resume,
+									NULL)
+};
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.remove		= omap_gpio_remove,
 	.driver		= {
 		.name	= "omap_gpio",
 		.pm	= &gpio_pm_ops,
-		.of_match_table = of_match_ptr(omap_gpio_match),
+		.of_match_table = omap_gpio_match,
 	},
 };
 
-- 
2.20.0

