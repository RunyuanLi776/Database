/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Interface;

import Business.JDBC;
import java.util.ArrayList;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author lenovo
 */
public class ProductJPanel extends javax.swing.JPanel {

    /**
     * Creates new form ProductJPanel
     */
    private JDBC jbdc;
    public ProductJPanel(JDBC jdbc,ArrayList<Object[]> products) {
       initComponents();
       this.jbdc = jbdc;
       populate(products);
    }
    
    private void populate(ArrayList<Object[]> products) {
        DefaultTableModel model = (DefaultTableModel)prodTbl.getModel();
        model.setRowCount(0);
        
        for(Object[] product:products){
            Object[] row = new Object[10];
            for(int j = 0;j<10;j++) row[j] = product[j];
            model.addRow(row);
        }
        
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        prodTbl = new javax.swing.JTable();

        prodTbl.setBackground(new java.awt.Color(51, 51, 51));
        prodTbl.setForeground(new java.awt.Color(255, 255, 255));
        prodTbl.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "ProductID", "SellerID", "Description", "Color", "Brand", "RetailPrice", "ReleaseDate", "Type", "Quantity", "SalePrice"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.Integer.class, java.lang.Integer.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.Integer.class, java.lang.String.class, java.lang.String.class, java.lang.Integer.class, java.lang.Integer.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false, false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        jScrollPane1.setViewportView(prodTbl);
        if (prodTbl.getColumnModel().getColumnCount() > 0) {
            prodTbl.getColumnModel().getColumn(0).setResizable(false);
            prodTbl.getColumnModel().getColumn(1).setResizable(false);
            prodTbl.getColumnModel().getColumn(2).setResizable(false);
            prodTbl.getColumnModel().getColumn(3).setResizable(false);
            prodTbl.getColumnModel().getColumn(4).setResizable(false);
            prodTbl.getColumnModel().getColumn(5).setResizable(false);
            prodTbl.getColumnModel().getColumn(6).setResizable(false);
            prodTbl.getColumnModel().getColumn(7).setResizable(false);
            prodTbl.getColumnModel().getColumn(8).setResizable(false);
            prodTbl.getColumnModel().getColumn(9).setResizable(false);
        }

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 900, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 600, Short.MAX_VALUE)
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JTable prodTbl;
    // End of variables declaration//GEN-END:variables
}
