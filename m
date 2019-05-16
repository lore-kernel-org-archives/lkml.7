Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAD3C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C4E4205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfEPIqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:46:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:23525 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfEPIqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:46:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 May 2019 01:46:36 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2019 01:46:33 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hRC23-0000bu-Ua; Thu, 16 May 2019 11:46:31 +0300
Date:   Thu, 16 May 2019 11:46:31 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] vfio-mdev/samples: make some symbols static
Message-ID: <20190516084631.GX9224@smile.fi.intel.com>
References: <20190516015526.141404-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516015526.141404-1-wangkefeng.wang@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 09:55:26AM +0800, Kefeng Wang wrote:
> Make some structs and functions static to fix build warning, parts of
> warning shown below,
> 
> amples/vfio-mdev/mtty.c:730:5: warning: symbol 'mtty_create' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:780:5: warning: symbol 'mtty_remove' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:802:5: warning: symbol 'mtty_reset' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:818:9: warning: symbol 'mtty_read' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:877:9: warning: symbol 'mtty_write' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:1070:5: warning: symbol 'mtty_get_region_info' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:1119:5: warning: symbol 'mtty_get_irq_info' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:1143:5: warning: symbol 'mtty_get_device_info' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:1275:5: warning: symbol 'mtty_open' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:1281:6: warning: symbol 'mtty_close' was not declared. Should it be static?
> samples/vfio-mdev/mtty.c:1305:30: warning: symbol 'mtty_dev_groups' was not declared. Should it be static?
> 

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  samples/vfio-mdev/mtty.c | 44 ++++++++++++++++++++--------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
> index 1c77c370c92f..880eeac0c7c9 100644
> --- a/samples/vfio-mdev/mtty.c
> +++ b/samples/vfio-mdev/mtty.c
> @@ -72,7 +72,7 @@
>   * Global Structures
>   */
>  
> -struct mtty_dev {
> +static struct mtty_dev {
>  	dev_t		vd_devt;
>  	struct class	*vd_class;
>  	struct cdev	vd_cdev;
> @@ -88,7 +88,7 @@ struct mdev_region_info {
>  };
>  
>  #if defined(DEBUG_REGS)
> -const char *wr_reg[] = {
> +static const char *wr_reg[] = {
>  	"TX",
>  	"IER",
>  	"FCR",
> @@ -99,7 +99,7 @@ const char *wr_reg[] = {
>  	"SCR"
>  };
>  
> -const char *rd_reg[] = {
> +static const char *rd_reg[] = {
>  	"RX",
>  	"IER",
>  	"IIR",
> @@ -147,8 +147,8 @@ struct mdev_state {
>  	int nr_ports;
>  };
>  
> -struct mutex mdev_list_lock;
> -struct list_head mdev_devices_list;
> +static struct mutex mdev_list_lock;
> +static struct list_head mdev_devices_list;
>  
>  static const struct file_operations vd_fops = {
>  	.owner          = THIS_MODULE,
> @@ -171,7 +171,7 @@ static struct mdev_state *find_mdev_state_by_uuid(const guid_t *uuid)
>  	return NULL;
>  }
>  
> -void dump_buffer(u8 *buf, uint32_t count)
> +static void dump_buffer(u8 *buf, uint32_t count)
>  {
>  #if defined(DEBUG)
>  	int i;
> @@ -727,7 +727,7 @@ static ssize_t mdev_access(struct mdev_device *mdev, u8 *buf, size_t count,
>  	return ret;
>  }
>  
> -int mtty_create(struct kobject *kobj, struct mdev_device *mdev)
> +static int mtty_create(struct kobject *kobj, struct mdev_device *mdev)
>  {
>  	struct mdev_state *mdev_state;
>  	char name[MTTY_STRING_LEN];
> @@ -777,7 +777,7 @@ int mtty_create(struct kobject *kobj, struct mdev_device *mdev)
>  	return 0;
>  }
>  
> -int mtty_remove(struct mdev_device *mdev)
> +static int mtty_remove(struct mdev_device *mdev)
>  {
>  	struct mdev_state *mds, *tmp_mds;
>  	struct mdev_state *mdev_state = mdev_get_drvdata(mdev);
> @@ -799,7 +799,7 @@ int mtty_remove(struct mdev_device *mdev)
>  	return ret;
>  }
>  
> -int mtty_reset(struct mdev_device *mdev)
> +static int mtty_reset(struct mdev_device *mdev)
>  {
>  	struct mdev_state *mdev_state;
>  
> @@ -815,7 +815,7 @@ int mtty_reset(struct mdev_device *mdev)
>  	return 0;
>  }
>  
> -ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
> +static ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  		  loff_t *ppos)
>  {
>  	unsigned int done = 0;
> @@ -874,7 +874,7 @@ ssize_t mtty_read(struct mdev_device *mdev, char __user *buf, size_t count,
>  	return -EFAULT;
>  }
>  
> -ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
> +static ssize_t mtty_write(struct mdev_device *mdev, const char __user *buf,
>  		   size_t count, loff_t *ppos)
>  {
>  	unsigned int done = 0;
> @@ -1067,7 +1067,7 @@ static int mtty_trigger_interrupt(const guid_t *uuid)
>  	return ret;
>  }
>  
> -int mtty_get_region_info(struct mdev_device *mdev,
> +static int mtty_get_region_info(struct mdev_device *mdev,
>  			 struct vfio_region_info *region_info,
>  			 u16 *cap_type_id, void **cap_type)
>  {
> @@ -1116,7 +1116,7 @@ int mtty_get_region_info(struct mdev_device *mdev,
>  	return 0;
>  }
>  
> -int mtty_get_irq_info(struct mdev_device *mdev, struct vfio_irq_info *irq_info)
> +static int mtty_get_irq_info(struct mdev_device *mdev, struct vfio_irq_info *irq_info)
>  {
>  	switch (irq_info->index) {
>  	case VFIO_PCI_INTX_IRQ_INDEX:
> @@ -1140,7 +1140,7 @@ int mtty_get_irq_info(struct mdev_device *mdev, struct vfio_irq_info *irq_info)
>  	return 0;
>  }
>  
> -int mtty_get_device_info(struct mdev_device *mdev,
> +static int mtty_get_device_info(struct mdev_device *mdev,
>  			 struct vfio_device_info *dev_info)
>  {
>  	dev_info->flags = VFIO_DEVICE_FLAGS_PCI;
> @@ -1272,13 +1272,13 @@ static long mtty_ioctl(struct mdev_device *mdev, unsigned int cmd,
>  	return -ENOTTY;
>  }
>  
> -int mtty_open(struct mdev_device *mdev)
> +static int mtty_open(struct mdev_device *mdev)
>  {
>  	pr_info("%s\n", __func__);
>  	return 0;
>  }
>  
> -void mtty_close(struct mdev_device *mdev)
> +static void mtty_close(struct mdev_device *mdev)
>  {
>  	pr_info("%s\n", __func__);
>  }
> @@ -1302,7 +1302,7 @@ static const struct attribute_group mtty_dev_group = {
>  	.attrs = mtty_dev_attrs,
>  };
>  
> -const struct attribute_group *mtty_dev_groups[] = {
> +static const struct attribute_group *mtty_dev_groups[] = {
>  	&mtty_dev_group,
>  	NULL,
>  };
> @@ -1329,7 +1329,7 @@ static const struct attribute_group mdev_dev_group = {
>  	.attrs = mdev_dev_attrs,
>  };
>  
> -const struct attribute_group *mdev_dev_groups[] = {
> +static const struct attribute_group *mdev_dev_groups[] = {
>  	&mdev_dev_group,
>  	NULL,
>  };
> @@ -1351,7 +1351,7 @@ name_show(struct kobject *kobj, struct device *dev, char *buf)
>  	return -EINVAL;
>  }
>  
> -MDEV_TYPE_ATTR_RO(name);
> +static MDEV_TYPE_ATTR_RO(name);
>  
>  static ssize_t
>  available_instances_show(struct kobject *kobj, struct device *dev, char *buf)
> @@ -1379,7 +1379,7 @@ available_instances_show(struct kobject *kobj, struct device *dev, char *buf)
>  	return sprintf(buf, "%d\n", (MAX_MTTYS - used)/ports);
>  }
>  
> -MDEV_TYPE_ATTR_RO(available_instances);
> +static MDEV_TYPE_ATTR_RO(available_instances);
>  
>  
>  static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
> @@ -1388,7 +1388,7 @@ static ssize_t device_api_show(struct kobject *kobj, struct device *dev,
>  	return sprintf(buf, "%s\n", VFIO_DEVICE_API_PCI_STRING);
>  }
>  
> -MDEV_TYPE_ATTR_RO(device_api);
> +static MDEV_TYPE_ATTR_RO(device_api);
>  
>  static struct attribute *mdev_types_attrs[] = {
>  	&mdev_type_attr_name.attr,
> @@ -1407,7 +1407,7 @@ static struct attribute_group mdev_type_group2 = {
>  	.attrs = mdev_types_attrs,
>  };
>  
> -struct attribute_group *mdev_type_groups[] = {
> +static struct attribute_group *mdev_type_groups[] = {
>  	&mdev_type_group1,
>  	&mdev_type_group2,
>  	NULL,
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


